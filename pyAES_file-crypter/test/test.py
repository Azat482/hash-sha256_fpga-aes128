import numpy as np

a = 1872
print((a.bit_length() + 7) // 8)

n = a.to_bytes(4, 'big')
arr = np.zeros(16, dtype=np.uint8)

j = 0
for i in range(12, 16):
    arr[i] = n[j]
    j = j + 1
    
print(arr)