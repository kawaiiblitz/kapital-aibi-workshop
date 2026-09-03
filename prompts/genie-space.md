# Genie Space — analitica conversacional

Un Genie Space deja que cualquier persona del negocio pregunte a los datos en lenguaje
natural y reciba tablas y graficas, sin escribir SQL.

## Al crear el Space
- **Tablas:** agrega las 4 tablas de tu esquema: `clientes`, `tarjetas`, `transacciones`, `cobranza`.
- **Nombre sugerido:** `Analitica Comercial - Taller`

## Instrucciones generales (pegalas en la config del Space)

```
Los montos estan en pesos mexicanos. "Cartera" se refiere a las tarjetas de credito.
"Mora" es el atraso en pagos, esta en la tabla cobranza. Un cliente "activo" es aquel
con estatus = 'Activo'. Cuando alguien pregunte por "clientes que pagan" o "buenos
pagadores", ordena por prob_pago descendente. El periodo por defecto es los ultimos
90 dias, que es lo que cubre la tabla transacciones.
```

## Preguntas de ejemplo (agregalas como sample questions)

- ¿Cuántos clientes activos tenemos por país?
- ¿Cuál es el saldo utilizado promedio por tipo de tarjeta?
- Muéstrame el monto total transaccionado por categoría en los últimos 30 días
- ¿Qué segmento de clientes tiene mayor monto vencido?
- Top 10 ciudades por número de transacciones
- ¿Cuál es la probabilidad de pago promedio por tramo de mora?

---

## Preguntas para probar Genie en vivo (seccion 5 del taller)

Escríbelas tal cual en el Space (o en el botón **Ask Genie** del dashboard):

1. ¿Cuántas tarjetas tipo Platino están vigentes?
2. Compara el monto transaccionado entre México y Colombia
3. ¿Cuál es el ticket promedio por canal?
4. Dame el monto vencido total del tramo "90+ dias"
5. ¿Qué categoría de gasto creció más en el último mes?
6. Muéstrame los 15 clientes con mayor límite de crédito y su saldo utilizado

### Prueba de seguimiento (follow-up)
Genie mantiene contexto. Después de una respuesta, pregunta encima:
- "ahora solo para México"
- "y ordénalo de mayor a menor"
- "muéstralo como gráfica de barras"
