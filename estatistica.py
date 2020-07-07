#!/bin/python3

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

data = pd.read_csv("log_dados.csv", delimiter = ';',encoding='utf-8')

# print(data)

print(data['cpu_em_uso'].groupby(['cpu_em_uso']).count().unstack('cpu_em_uso'))