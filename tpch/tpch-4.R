library(gtBase)

orders <- Read(orders100g)
lineitem <- Read(lineitem100g)

selord <- orders[o_orderdate >= .(as.Date("1993-07-01")) && o_orderdate <= .(as.Date("1993-10-01"))]
selline <- lineitem[l_commitdate < l_receiptdate]

j <- Join(selline, l_orderkey, selord, o_orderkey)

groupby <- GroupBy(j,
                   group = c(o_orderpriority),
                   order_count = Count()
                  )

orderby <- OrderBy(groupby, dsc(o_orderpriority), limit = 10)

View(orderby)
