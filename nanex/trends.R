require(gtBase)
options(show.piggy = TRUE)

data = Read(nanex_exgquotes)[Type == "Equity"]

agg <- GroupBy(
  data,
  group = Symbol,
  Trends(inputs = MsOfDay, outputs = c(trend, trades, count),
         begin = 12902825L, end = 72002351L)
)

View(agg)
