library(gtBase)

customer <- Read(customer100g)
orders <- Read(orders100g)
lineitem <- Read(lineitem100g)

selcust <- customer[c_mktsegment == "BUILDING"]
selord <- orders[o_orderdate < .(as.Date("1995-03-15"))]
selline <- lineitem[l_shipdate > .(as.Date("1995-03-15"))]

j1 <- Join(selord, o_custkey, selcust, c_custkey)
j2 <- Join(selline, l_orderkey, j1, o_orderkey)

groupby <- GroupBy(j2,
                   group = c(l_orderkey, o_orderdate, o_shippriority),
                   revenue = Sum(l_extendedprice * (1 - l_discount))
                  )

orderby <- OrderBy(groupby, dsc(revenue), asc(o_orderdate), limit = 10)

View(orderby)
