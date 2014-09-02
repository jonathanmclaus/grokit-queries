library(gtBase)

lineitem <- Read(lineitem100g)

selline <- lineitem[l_shipdate >= .(as.Date("1994-01-01"))
                    && l_shipdate < .(as.Date("1995-01-01"))
                    && l_discount <= 0.07
                    && l_discount >= 0.05
                    && l_quantity < 24]

agg <- Sum(selline, l_extendedprice * l_discount, revenue)

View(agg)
