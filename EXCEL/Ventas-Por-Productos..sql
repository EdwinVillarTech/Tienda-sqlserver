USE TiendaDB;

SELECT 
    pr.nombre                              AS Producto,
    SUM(dp.cantidad)                       AS CantidadVendida,
    SUM(dp.Cantidad * dp.PrecioUnitario)   AS TotalVentas
FROM Productos pr
INNER JOIN DetallePedidos dp ON Pr.ProductoID = dp.ProductoID
Group by pr.Nombre
ORDER BY TotalVentas Desc;


SELECT  
     c.Nombre + ' ' + c.Apellido           AS Cliente,
     COUNT(DISTINCT p.PedidoID)            AS TotalPedidos,
     SUM(dp.Cantidad * dp.PrecioUnitario)  AS TotalGastado
FROM
     Clientes c
INNER JOIN Pedidos p   ON c.ClienteID = P.ClienteID
INNER JOIN DetallePedidos dp ON p.PedidoID =dp.PedidoID
WHERE p.Estado <> 'Cancelado'
GROUP BY c.Nombre, Apellido
ORDER BY TotalGastado DESC;





SELECT 
     P.Estado,
     COUNT(DISTINCT p.PedidoID)            AS TotalPedidos,
     SUM(dp.Cantidad * dp.PrecioUnitario) AS TotalVentas
FROM Pedidos p
INNER JOIN DetallePedidos dp ON p.PedidoID =dp.PedidoID
GROUP BY P.Estado 
ORDER BY TotalPedidos DESC;



