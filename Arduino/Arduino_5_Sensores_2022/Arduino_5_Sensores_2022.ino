// Inclusão de bibliotecas
#include <DHT.h>
#include <DHT_U.h>
#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>
#include "DHT.h"
// Definição de porta de entrada
#define DHTPIN A1
DHT dht(DHTPIN, DHT11);

// Inicialização de biblioteca , definir serial
void setup()
{
pinMode(DHTPIN, INPUT);
Serial.begin(9600);
dht.begin();
}

// Inicia Loop
void loop()
{

 // Definição de Variável decimal
float dht11_umidade = dht.readHumidity();
float dht11_temperatura = dht.readTemperature();

// Exibir na tela
Serial.print(dht11_umidade);
Serial.print(";");
Serial.print(dht11_temperatura);


Serial.println();

// Tempo da captura em milisegundos/segundos
delay(20000);
} 
