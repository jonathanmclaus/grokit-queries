library(gtBase)

part <- Read(part1t)
supplier <- Read(supplier1t)
partsupp <- Read(partsupp1t)
nation <- Read(nation1t)
region <- Read(region1t)

selpart <- part[match(p_type$ToString(), ".*BRASS") && p_size == 15]
selregion <- region[r_name == "EUROPE"]

j1 <- Join(nation, n_regionkey, selregion, r_regionkey)
j2 <- Join(supplier, s_nationkey, j1, nation@n_nationkey)
j3 <- Join(partsupp, ps_partkey, selpart, p_partkey)
j4 <- Join(j3, ps_suppkey, j2, s_suppkey)

groupby <- GroupBy(j4,
                   group = p_partkey,
                   ExtremeTuples(inputs = c(s_acctbal, s_name, n_name, p_mfgr, s_address, s_phone, s_comment),
                                 outputs = c(s_acctbal, s_name, n_name, p_mfgr, s_address, s_phone, s_comment),
                                 min(ps_supplycost))
                  )

orderby <- OrderBy(groupby, dsc(s_acctbal), asc(n_name), asc(s_name), asc(p_partkey), limit = 100)

View(orderby)
