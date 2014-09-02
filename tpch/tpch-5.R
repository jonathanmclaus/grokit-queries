library(gtBase)
options(show.piggy = TRUE)

customer <- Read(customer100g)
orders <- Read(orders100g)
lineitem <- Read(lineitem100g)
supplier <- Read(supplier100g)
nation <- Read(nation100g)
region <- Read(region100g)

selregion <- region[r_name == "ASIA"]
selord <- orders[o_orderdate >= .(as.Date("1994-01-01")) && o_orderdate <= .(as.Date("1995-01-01"))]

j1 <- Join(nation, n_regionkey, selregion, r_regionkey)
j2 <- Join(customer, c_nationkey, j1, n_nationkey)
j3 <- Join(selord, o_orderkey, j2, c_custkey)
j4 <- Join(lineitem, l_orderkey, j3, o_orderkey)
j5 <- Join(j4, c(l_suppkey, c_nationkey), supplier, c(s_suppkey, s_nationkey))

groupby <- GroupBy(j5,
                   group = n_name,
                   revenue = Sum(l_extendedprice * (1 - l_discount))
                  )

orderby <- OrderBy(groupby, dsc(revenue))

View(orderby)
