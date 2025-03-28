![image](https://github.com/user-attachments/assets/fd9a56bd-8361-4e38-ab01-78aa50e386a1)
![image](https://github.com/user-attachments/assets/1fa68452-52cf-420d-9f21-6c56643efb64)
![image](https://github.com/user-attachments/assets/8457aa54-55a1-4c12-98cc-db4e505c9509)
![image](https://github.com/user-attachments/assets/e8e1ceef-c2ae-47dd-a52f-0eebe21ab800)
![image](https://github.com/user-attachments/assets/872d78f8-2116-4573-9e5d-4fe9ed9e3f0e)


Проект: Реализация алгоритма AES для шифрования и дешифрования данных

Этот проект включает несколько реализаций алгоритма AES (Advanced Encryption Standard) на разных языках программирования и платформах, включая программные и аппаратные решения. Основная цель — разработка, тестирование и сравнение производительности шифрования и дешифрования данных.

1) Программа на C для вычисления хэша SHA-256:
Разработана утилита на языке C для получения хэш-значений файлов с использованием алгоритма SHA-256. Использовалась для проверки корректности реализаций AES путем сравнения хэшей исходных файлов и файлов, полученных после расшифровки.
3) Реализация AES на C:
Создана программная реализация алгоритма AES на языке C для шифрования и дешифрования файлов. Проведена полная отладка кода.
4) Модуль PyAES_CPU.py на Python:
Разработан независимый модуль на Python, реализующий алгоритм AES для шифрования и дешифрования данных.
5) Программа на Python с использованием PyAES_CPU.py:
Создана полноценная программа на Python, использующая модуль PyAES_CPU.py для шифрования и дешифрования файлов.
6) Аппаратная реализация AES на Verilog:
Алгоритм AES реализован на языке описания аппаратуры Verilog для работы на программируемых логических интегральных схемах (ПЛИС).
7) Симуляция в ModelSim:
Проведена симуляция и отладка аппаратной реализации AES в среде ModelSim.
8) Проект для платы DE10-Lite в Quartus Prime:
На основе кода Verilog разработан проект в Quartus Prime для платы DE10-Lite с ПЛИС MAX10. Реализация позволяет шифровать и дешифровать данные, передаваемые через последовательный интерфейс RS-232.
9) Интеграция с Python GUI:
В существующую программу на Python с графическим интерфейсом добавлена поддержка шифрования и дешифрования файлов с использованием ПЛИС MAX10.
10) Измерение производительности:
С помощью инструмента SignalTap в Quartus Prime измерено время обработки одного блока данных на ПЛИС MAX10 — 440 наносекунд. Это на порядок быстрее, чем результаты программных реализаций AES на Python и C, что демонстрирует высокую скорость аппаратного шифрования.

Цели проекта:
Сравнение производительности программных (C, Python) и аппаратных (Verilog, ПЛИС) реализаций AES.
Разработка универсального решения для шифрования данных с использованием как программных, так и аппаратных подходов.
Интеграция аппаратного шифрования в удобный графический интерфейс.

Используемые инструменты:
Языки программирования: C, Python, Verilog
Среда разработки ПЛИС: Quartus Prime, ModelSim
Аппаратная платформа: DE10-Lite (ПЛИС MAX10)
Инструменты анализа: SignalTap

Результаты:
Аппаратная реализация на ПЛИС MAX10 обеспечивает значительное преимущество в скорости по сравнению с программными аналогами, что делает её предпочтительной для задач, требующих высокой производительности.
