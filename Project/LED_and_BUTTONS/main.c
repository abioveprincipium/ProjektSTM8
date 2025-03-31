/**
  ******************************************************************************
  * @file    Project/main.c 
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   Main program body
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */ 

/* ============================================================================
 * SEKCJA: Includes
 * ============================================================================
 */
#include "stm8s.h"

/* ============================================================================
 * SEKCJA: Definicje
 * ============================================================================
 */
#define CCR1_Val     ((uint16_t)976)
#define SIMULATION

/* ============================================================================
 * SEKCJA: Zmienne globalne
 * ============================================================================
 */
int count = 0;                  // uzywane w obsludze przyciskow
unsigned short tick_start = 0;  // uzywane przy tick_ms
volatile unsigned long tick_ms = 0; // uzywane w przerwaniach
int help = 0;                   // uzywane przy sprawdzaniu TIM4

/* Wyeksponowane zmienne globalne definiowane w innych plikach -  'extern') */
extern uint8_t key_flag, key_mode;
extern uint16_t key_count;



/* ============================================================================
 * SEKCJA: Funkcje prywatne
 * ============================================================================
 */
void delay(uint16_t tick);
void uart_s_string(const char* str);

/**
  * @brief  Funkcja opozniajaca
  * @param  tick: liczba cykli opoznienia, zalezy od czestotliwosci pracy procesora
  * @retval None
  */
void delay(uint16_t tick)
{
    while (--tick);
}

/**
  * @brief  Funkcja do wysylania lañcucha znakow przez UART1
  * @param  str wskaznik na lancuch znakow zakonczony \0
  * @retval None
  */
void uart_s_string(const char* str)
{
    while (*str)
    {
        while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
        UART1_SendData8(*str++);
    }
}

/* ============================================================================
 * SEKCJA: Funkcja Main
 * ============================================================================
 */
void main(void)
{
    /* ------------------------------------------------------------------------
     * SEKCJA A: Inicjalizacja GPIO
     * ------------------------------------------------------------------------
     * Piny PC5, PC6, PC7 jako wyjscia (diody led); PB2, PB3, PB4 jako wejscia (przyciski)
     */
    GPIO_Init(GPIOC, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_SLOW);
    GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_SLOW);
    GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_OUT_PP_HIGH_SLOW);

    GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_IN_FL_NO_IT);
    GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
    GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);

    /* ------------------------------------------------------------------------
     * SEKCJA B: Inicjalizacja UART1
     * ------------------------------------------------------------------------
     */
    UART1_Init((uint32_t)115200, 
               UART1_WORDLENGTH_8D, 
               UART1_STOPBITS_1, 
               UART1_PARITY_NO, 
               UART1_SYNCMODE_CLOCK_DISABLE, 
               UART1_MODE_TX_ENABLE);

    /* ------------------------------------------------------------------------
     * SEKCJA C: Inicjalizacja TIM2
     * ------------------------------------------------------------------------
     * Ustawienie preskalera, okresu i trybu, plus wlaczenie przerwan.
     * (Wymaga funkcji obslugi w przerwaniach - stm8_interrupt_vector.c)
     */
    TIM2_TimeBaseInit(TIM2_PRESCALER_1, 10000);
    TIM2_OC1Init(TIM2_OCMODE_INACTIVE, 
                 TIM2_OUTPUTSTATE_ENABLE,
                 100, 
                 TIM2_OCPOLARITY_HIGH);
    TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
    TIM2_ITConfig(TIM2_IT_CC1, ENABLE);
    TIM2_Cmd(ENABLE);

    /* ------------------------------------------------------------------------
     * SEKCJA D: Inicjalizacja TIM4
     * ------------------------------------------------------------------------
     * Ustawienie preskalera, okresu i trybu, plus wlaczenie przerwan.
     * (Wymaga funkcji obslugi w przerwaniach - stm8_interrupt_vector.c)
     */
    TIM4_TimeBaseInit(TIM4_PRESCALER_8, 249);
    TIM4_Cmd(ENABLE);
    TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);

    /* ------------------------------------------------------------------------
     * SEKCJA E: Wlaczenie przerwan globalnych
     * ------------------------------------------------------------------------
     */
    enableInterrupts();

    /* ------------------------------------------------------------------------
     * SEKCJA F: Glowna petla programu
     * ------------------------------------------------------------------------
     */
    while (1)
    {
        /* =========================================================
         * 1) Miganie dioda z uzyciem opoznienia i UART
         * =========================================================
         */
        GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
        uart_s_string("LED ON\n");
        delay(10000);

        GPIO_WriteLow(GPIOC, GPIO_PIN_5);
        uart_s_string("LED OFF\n");
        delay(10000);

        /* =========================================================
         * 2) Obsluga flagi key_flag
         *    Mrugniecie dioda PC5, jesli key_flag ustawione na true
         * =========================================================
         */
        if (key_flag)
        {
            GPIO_WriteLow(GPIOC, GPIO_PIN_5);
            delay(1000);
            GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
            key_flag--;
        }

        /* =========================================================
         * 3)  Miganie dioda z u¿yciem tick_ms
         * =========================================================
         */
        if (tick_ms >= (tick_start + 500))
        {
            tick_start += 500;
            GPIO_WriteReverse(GPIOC, GPIO_PIN_5);
        }

        /* =========================================================
         * 4) Sprawdzanie przerwania TIM4 (flaga TIM4_FLAG_UPDATE)
         *    Dodatkowe dzialanie: odwrocenie stanu diody
         * =========================================================
         */
        if (TIM4_GetFlagStatus(TIM4_FLAG_UPDATE))
        {
            TIM4_ClearFlag(TIM4_FLAG_UPDATE);
            GPIO_WriteReverse(GPIOC, GPIO_PIN_5);
            help++;
        }

        /* =========================================================
         * 5) Reakcja na stan wejscia PB4 - RESET stan niski, w przeciwnym wypadku stan wysoki
         * =========================================================
         */
        if (GPIO_ReadInputPin(GPIOB, GPIO_PIN_4) == RESET)
        {
            GPIO_WriteLow(GPIOC, GPIO_PIN_5);
        }
        else
        {
            GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
        }

        /* =========================================================
         * 6) Licznik nacisniec przycisku PB4
         * =========================================================
         */
        while ((GPIO_ReadInputData(GPIOB) & GPIO_PIN_4) != RESET);
        count++;
        while ((GPIO_ReadInputData(GPIOB) & GPIO_PIN_4) == RESET);

        /* =========================================================
         * 7) Miganie dioda z opoznieniem (65000)
         * =========================================================
         */
        GPIO_WriteLow(GPIOC, GPIO_PIN_5);
        delay(65000);
        GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
        delay(65000);

        GPIO_WriteReverse(GPIOC, GPIO_PIN_5);
    }
}

#ifdef USE_FULL_ASSERT
/**
  * @brief  Raportuje nazwe pliku i linie kodu, gdzie wystapil blad asercji
  * @param  file: wskaznik do nazwy pliku zrodlowego
  * @param  line: numer linii
  * @retval None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* Obsluga bledow */
  while (1)
  {
  }
}
#endif

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
