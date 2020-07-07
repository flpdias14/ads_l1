#!/bin/python3

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

data = pd.read_csv("log_dados.csv", delimiter = ';',encoding='utf-8')


hist_plot = data['cpu_em_uso'].hist(bins=25, grid=False)
hist_plot.set_title('Histograma de CPUs')
hist_plot.set_xlabel('CPU')
hist_plot.set_ylabel('# Ocorrências')
plt.show()
# print(data)

