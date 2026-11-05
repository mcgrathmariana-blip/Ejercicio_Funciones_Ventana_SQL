
-- ==========================================
-- EJERCICIO: FUNCIONES DE VENTANA EN SQL
-- Análisis de ventas
-- ==========================================

-- 1. CREACIÓN DE LA TABLA

CREATE TABLE IF NOT EXISTS pedidos (
    pedido_id INTEGER PRIMARY KEY,
    cliente_id INTEGER,
    fecha TEXT,
    importe REAL,
    categoria TEXT
);

-- 2. INSERCIÓN DE DATOS DE PRUEBA

INSERT OR IGNORE INTO pedidos VALUES
(1, 101, '2026-01-05', 500, 'Electrónica'),
(2, 102, '2026-01-06', 300, 'Hogar'),
(3, 101, '2026-01-08', 700, 'Electrónica'),
(4, 103, '2026-01-10', 200, 'Hogar'),
(5, 102, '2026-01-12', 400, 'Electrónica'),
(6, 101, '2026-01-15', 600, 'Hogar'),
(7, 103, '2026-01-18', 800, 'Electrónica'),
(8, 102, '2026-01-20', 500, 'Hogar');


-- ==========================================
-- CONSULTA 1: PROMEDIO HISTÓRICO POR CLIENTE
-- ==========================================

SELECT
    pedido_id,
    cliente_id,
    fecha,
    importe,
    categoria,

    -- PARTITION BY separa los cálculos por cliente
    -- sin eliminar los registros individuales.

    AVG(importe) OVER (
        PARTITION BY cliente_id
    ) AS promedio_cliente

FROM pedidos
ORDER BY cliente_id, fecha;


-- ==========================================
-- CONSULTA 2: VENTAS ACUMULADAS
-- ==========================================

SELECT
    fecha,
    importe,

    -- ORDER BY fecha permite acumular las ventas
    -- cronológicamente, desde la primera fila
    -- hasta la fila actual.

    SUM(importe) OVER (
        ORDER BY fecha
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS ventas_acumuladas

FROM pedidos
ORDER BY fecha;


-- ==========================================
-- CONSULTA 3: CONTRIBUCIÓN POR CATEGORÍA
-- ==========================================

SELECT
    pedido_id,
    cliente_id,
    fecha,
    importe,
    categoria,

    -- Calcula el total de ventas de cada categoría.

    SUM(importe) OVER (
        PARTITION BY categoria
    ) AS total_categoria,

    -- Calcula el porcentaje que representa
    -- cada pedido sobre el total de su categoría.

    ROUND(
        importe * 100.0 /
        SUM(importe) OVER (
            PARTITION BY categoria
        ), 2
    ) AS porcentaje_contribucion

FROM pedidos
ORDER BY categoria, fecha;
