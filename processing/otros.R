elsoc_long_2016_2023 %>% 
  filter(ola == 1) %>% 
  select(just_educ, just_pension, just_health) %>% 
  mutate_all(~ as.numeric(.)) %>% 
  psych::alpha()

texreg::screenreg(list(m10, m11, m12, m13, m14),
                  digits = 3)

library(ggeffects)

pred(m11, terms = c("ola_num", 
                         "merit_effort" )) %>% 
  plot() 


marginaleffects::plot_slopes(model = m11,
                             variables = "merit_effort",
                             condition = "ola_num",
                             conf_level = .95) +
  geom_hline(yintercept = 0,
             color = "red",
             linetype = "dashed") +
  labs(x = "Meritocracy: Effort [WE]",
       y = "Marginal effect of meritocracy: effort",
       fill = NULL,
       caption = "Fuente: Elaboración propia en base a ISSP (1999-2019) y WID
       Intervalos de confianza al 95%") +
  my_pretty_theme() +
  theme(legend.position = "none")
