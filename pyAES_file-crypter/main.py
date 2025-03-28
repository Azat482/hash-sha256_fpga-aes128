from operator import mod
from posixpath import split
import sys
import os
import timeit
from tkinter.constants import CENTER, LEFT, RIGHT, TOP, X
import PyAES_CPU
import PyAES_FPGA
import numpy as np
import traceback
import tkinter as tk
import tkinter.filedialog as fd
from timeit import default_timer as timer


def file_crypter(method, file_path, output_file_path, output_file_name, padding_chunk_flag):
    chunk_size = 1024 * 4
    chunk_size += 16 if padding_chunk_flag else 0
    try:
        with open(file_path, 'rb') as original_file, open(os.path.join(output_file_path, output_file_name), 'wb') as output_file:
            chunk = original_file.read(chunk_size)
            while chunk:
                output_file.write(bytes(method(chunk)))
                chunk = original_file.read(chunk_size)                            
    except Exception as e:
        print(e)
        print(traceback.format_exc())

def main():
    arguments = sys.argv
    try:
        #console implementation
        if len(arguments) == 5:
            method = None
            module = None
            path   = arguments[3]
            key    = arguments[4]
            padding_chunk_flag = False
            #choise of device
            if arguments[1] == '--CPU':
                module = PyAES_CPU.SerialAES(4)
            elif arguments[1] == '--FPGA':
                module = PyAES_FPGA.SerialAES(4)
            else: raise Exception

            #encrypt or decrypt of the file
            if arguments[2] == '--encrypt':
                method = module.AES_cipher
            elif arguments[2] == '--decrypt':
                method = module.AES_decrypter
                padding_chunk_flag = True
            else: raise Exception
                        
            #key length must be 128, 182 or 256 bits
            if len(key) != 16 and len(key) != 24 and len(key) != 32 and not key.isascii():
                print('The length of the key is {}.'.format(len(key)))
                print('Key length must be 16, 24 or 32 bytes, only.')
                raise Exception
            
            #convert ASCII char array to uint8 array 
            key = np.array([ord(i) for i in key], dtype=np.uint8)
            
            #checking the existence of the file and running crypter function
            if os.path.isfile(path):
                name_of_output_file = ''
                output_file_path = ''
                name_of_output_file = input('The output file will be named [default={}]: '.format(os.path.split(path)[1]))
                if not name_of_output_file or name_of_output_file.isspace():
                    name_of_output_file = os.path.split(path)[1]
                print(name_of_output_file)
                while not(os.path.isdir(output_file_path)):
                    output_file_path = input('The output file will be placed in [default="{}"]: '.format(os.path.split(path)[0]))                
                    if not(output_file_path) or output_file_path.isspace():
                        output_file_path = os.path.split(path)[0]
                print(output_file_path)
                start_timer = timer()
                module.set_key(key)
                file_crypter(
                    method           = method,
                    file_path        = path,
                    output_file_path = output_file_path,
                    output_file_name = name_of_output_file,
                    padding_chunk_flag = padding_chunk_flag,
                    )        
                time_of_crypter = timer() - start_timer
                print('File operation time: {}'.format(time_of_crypter))    
            else:
                print('Such file %s is not exist.' % path) 
                raise Exception
        
        #gui implementation 
        elif len(arguments) == 1:

            window = tk.Tk()
            window.geometry('600x300+100+100')
            window.title('pyAES')

            r_device = tk.StringVar()
            r_method = tk.StringVar()
            tk_file_path = tk.StringVar()
            tk_output_file_dir = tk.StringVar()
            tk_output_file_name = tk.StringVar()
            tk_key = tk.StringVar()

            def choose_input_file():
                tk_file_path.set(fd.askopenfile(title='Input file', initialdir='/home').name)
                print(tk_file_path.get())

            def choose_output_file_directory():
                tk_output_file_dir.set(fd.askdirectory(title='File directory', initialdir='/home'))
                print(tk_output_file_dir.get())
            
            def start_aes():
                print('Device: {}'.format(r_device.get()))
                print('Method: {}'.format(r_method.get()))
                print('Path of input file: {}'.format(tk_file_path.get()))
                print('Output file directory: {}'.format(tk_output_file_dir.get()))
                print('Output file name: {}'.format(tk_output_file_name.get()))
                print('Key: {}'.format(tk_key.get()))
                
                #key length must be 128, 182 or 256 bits
                if len(tk_key.get()) != 16 and len(tk_key.get()) != 24 and len(tk_key.get()) != 32 and not tk_key.get().isascii():
                    print('The length of the key is {}.'.format(len(tk_key.get())))
                    print('Key length must be 16, 24 or 32 bytes, only.')
                    return
                aes_key = np.array([ord(i) for i in tk_key.get()], dtype = np.uint8)

                if os.path.isfile(tk_file_path.get()) and os.path.isdir(tk_output_file_dir.get()):
                    module = None
                    method = None
                    padding_chunk_flag = False

                     #choise of device
                    if r_device.get() == 'cpu':
                        module = PyAES_CPU.SerialAES(4)
                    elif r_device.get() == 'fpga':
                        module = PyAES_FPGA.SerialAES(4)
                    elif r_device.get() == 'gpu':
                        print('There is no such thing yet')
                        return
                    else: return

                    if r_method.get() == 'encrypt':
                        method = module.AES_cipher
                        padding_chunk_flag = False
                    elif r_method.get() == 'decrypt':
                        method = module.AES_decrypter
                        padding_chunk_flag = True
                    else: return

                    module.set_key(aes_key)
                    start_timer = timer()
                    file_crypter(
                        method=method,
                        file_path=tk_file_path.get(),
                        output_file_path = tk_output_file_dir.get(),
                        output_file_name=tk_output_file_name.get(),
                        padding_chunk_flag=padding_chunk_flag
                    )
                    end_timer = timer()
                    print('File operation time: {}s'.format(round(end_timer - start_timer, 4)))

            r_device.set('cpu')
            r_method.set('encrypt')
            
            frame1 = tk.Frame(window)
            frame1.pack(fill=X, pady=5)
            rb_enc = tk.Radiobutton(frame1, text = 'Encrypt', variable=r_method, value='encrypt', width=10, justify=LEFT)
            rb_dec = tk.Radiobutton(frame1, text = 'Decrypt', variable=r_method, value='decrypt', width=10,  justify=LEFT)
            rb_enc.pack(side=LEFT)
            rb_dec.pack(side=LEFT)

            frame2 = tk.Frame(window)
            frame2.pack(fill=X, pady=5)
            rb_cpu = tk.Radiobutton(frame2, text='CPU', variable=r_device, value='cpu', width=10,  justify=CENTER)
            rb_fpga = tk.Radiobutton(frame2, text='FPGA', variable=r_device, value='fpga', width=10, justify=LEFT)
            rb_cpu.pack(side=LEFT)
            rb_fpga.pack(side=LEFT)

            frame3 = tk.Frame(window)
            frame3.pack(fill=X, pady=5)
            btn_input_file = tk.Button(frame3, text = 'Input file', width=20, command=choose_input_file)
            lb_file_path = tk.Label(frame3, text='Choose file')
            btn_input_file.pack(side=LEFT, padx=5)
            lb_file_path.pack(side=LEFT, padx=5)
            def ch_lb_file_path(*argc):
                lb_file_path.config(text=tk_file_path.get())
            tk_file_path.trace('w', ch_lb_file_path)
            
            frame4 = tk.Frame(window)
            frame4.pack(fill=X, pady=5)
            btn_output_file_directory = tk.Button(frame4, text='Output file directory', width=20, command=choose_output_file_directory)
            lb_output_file_directory = tk.Label(frame4, text='Choose output file directory')
            btn_output_file_directory.pack(side=LEFT, padx=5)
            lb_output_file_directory.pack(side=LEFT, padx=5)
            def ch_lb_output_file_directory(*argc):
                lb_output_file_directory.config(text=tk_output_file_dir.get())
            tk_output_file_dir.trace('w', ch_lb_output_file_directory)

            frame5 = tk.Frame(window)
            frame5.pack(fill=X, pady=5)
            lb_output_file_name = tk.Label(frame5, width=22, text='Output file name: ')
            ent_output_file_name = tk.Entry(frame5, textvariable=tk_output_file_name)
            lb_output_file_name.pack(side=LEFT, padx=5)
            ent_output_file_name.pack(side=LEFT, padx=10, fill=X, expand=True)

            frame6 = tk.Frame(window)
            frame6.pack(fill=X, pady=5)
            lb_key = tk.Label(frame6, width=22, text='Enter key: ')
            ent_key = tk.Entry(frame6, textvariable=tk_key)
            lb_key.pack(side=LEFT, padx=5)
            ent_key.pack(side=LEFT, padx=10, fill=X, expand=True)

            btn_start = tk.Button(window, text='Start', width=10, command=start_aes)
            btn_start.pack(side=TOP, pady=5)


            window.mainloop()

        else:
            raise Exception
    except Exception as e:
        print('PROGRAMM ERROR!')
        print(e)

if __name__ == '__main__':
    main()