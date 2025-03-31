# STM8 - Miganie diodami, obsługa przycisków & UART

## Wprowadzenie

Projekt został wykonany w ramach zajęć laboratoryjnych, demonstruje użycie płytki Nucleo-8S208RB (z mikrokontrolerem STM8S208RBT6) do:

1. Migania diodami LED podłączonymi do portu PC.
2. Obsługi przycisków podłączonych do portu PB.
3. Inicjalizacji i konfiguracji UART1, TIM2 oraz TIM4.
4. Wykorzystania przerwań (kod przerwań w pliku stm8_interrupt_vector.c)
...

Standardowo znajduje się jedna dioda użytkownika (LED) oraz jeden przycisk użytkownika (USER Button).

- Dioda użytkownika – może być podłączona do wybranego pinu mikrokontrolera (D13 = PC5).
- Przycisk użytkownika (B1) – jest to PC4 na STM8 Nucleo.

Pozostałe piny (PC6, PC7, PB2, PB3, PB4) są wyprowadzone na złącza Arduino.

Projekt nadaje się do odtworzenia jako workspace w programie ST Visual Develop, do jego odtworzenia potrzebny jest plik licencyjny od Cosmic Software.

## Sekcje w pliku *main.c* 

**Zmienne globalne :**

Deklaracje i definicje zmiennych globalnych, w tym zmienne używane do zliczania czasu *(tick_ms, tick_start)*, flagi *(help, count)*, a także deklaracje zmiennych zewnętrznych *(extern)*.

**Funkcje prywatne :**

*delay()* : programowa funkcja opóźniająca zależna od taktowania CPU.

*uart_s_string()* : wysyła łańcuch znaków przez UART1.

**Funkcja Main :**
We wstępie znajdują się operacje inicjalizujące: GPIO (diody i przyciski), UART1, TIM2, TIM4 oraz włączenie przerwań (enableInterrupts()). 

Wpętli while(1) znajdują się różne przykłady:

1. Miganie diodą w oparciu o delay() i wysyłanie komunikatów przez UART.

2. Obsługa flagi key_flag – krótkie mrugnięcie diodą.

3. Miganie diodą sterowane wartością zmiennej tick_ms.

4. Sprawdzanie stanu przerwań z TIM4 (flaga TIM4_FLAG_UPDATE).

5. Odczyt stanu przycisku na PB4, ustawianie diody w zależności od wciśnięcia.

6. Zliczanie naciśnięć przycisku w zmiennej count.

7. Dodatkowe opóźnienia delay(65000) do przerw w miganiu diod.

## Uwagi dodatkowe
Dokładny schemat do tej płytki STM8S208RBT6 Nucleo znajduje się w pliku NUCLEO-8S208RB20Schematics.pdf.

Plik *stm8_interrupt_vector.c* zawiera tablicę wektorów przerwań i definicje funkcji ISR (Interrupt Service Routines).

## Licencja
Projekt jest udostępniany do użytku niekomercyjnego. Oznacza to, że możesz swobodnie przeglądać kod, jednak nie wolno wykorzystywać go w celach komercyjnych bez uzyskania odpowiedniej zgody.

## Kontakt
W przypadku pytań lub sugestii dotyczących projektu, proszę o kontakt poprzez zgłoszenia (issues) na GitHub.
