# Ejercicio práctico: Funciones de Ventana en SQL

## Descripción del proyecto

Este proyecto aplica funciones de ventana (Window Functions) para realizar un análisis de ventas utilizando SQL y una tabla llamada `pedidos`.

El objetivo es calcular métricas de negocio manteniendo el detalle de cada transacción, sin reducir los registros mediante GROUP BY.

## Estructura de la tabla

La tabla `pedidos` contiene las siguientes columnas:

- `pedido_id`: identificador único del pedido.
- `cliente_id`: identificador del cliente.
- `fecha`: fecha del pedido.
- `importe`: importe de la venta.
- `categoria`: categoría del producto.
