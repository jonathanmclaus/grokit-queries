library(gtBase)

grokit$schemas$catalog[[17]]$cluster = "l_shipdate"

lineitem <- Read(lineitem1t)

selline <- lineitem[l_shipdate <= .(as.Date("1998-12-01") - 90)]

groupby <- GroupBy(
  selline,
  group = c(rf = l_returnflag, ls = l_linestatus),
  sum_disc_price = Sum(l_extendedprice * (1 - l_discount)),
  sum_charge = Sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)),
  avg_qty = Average(l_quantity),
  count_order = Count(),
  sum_qty = Sum(l_quantity),
  avg_price = Average(l_extendedprice),
  sum_base_price = Sum(l_extendedprice),
  avg_disc = Average(l_discount)
)

orderby <- OrderBy(
  groupby,
  asc(rf),
  dsc(ls),
  rank = rank
)

View(orderby)
