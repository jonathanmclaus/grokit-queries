require(gtBase)

# Get quotes of type Equity
data <- Read(nanex_exgquotes)[Type == "Equity"]

# Group by Symbol and aggregate count
agg <- GroupBy(
  data,
  group = c(Symbol),
  QuoteCount = Count()
);

# Same for trades
data2 <- Read(nanex_trades)[Type == "Equity"]
agg2 <- GroupBy(
  data2,
  group = c(S2 = Symbol),
  TradeCount = Count()
);

# Join quotes and trades
jn <- Join(agg, Symbol, agg2, S2)

View(jn, Symbol, QuoteCount, TradeCount, Ratio = QuoteCount/TradeCount)
