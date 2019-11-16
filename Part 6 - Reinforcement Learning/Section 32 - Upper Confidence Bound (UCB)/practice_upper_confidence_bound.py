# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing the dataset
dataset = pd.read_csv('Ads_CTR_Optimisation.csv')

# Implementing UCB
import math
N = 10000
d = 10
ad_selection_numbers = [0] * d
ad_selected = []
sum_of_rewards = [0] * d
total_reward = 0
for i in range(N):
    ad = 0
    max_upper_bound = 0
    for j in range(d):
        if ad_selection_numbers[j] > 0:
            average_reward = sum_of_rewards[j]/ad_selection_numbers[j]
            delta_i = math.sqrt((3/2) * math.log(i+1) / ad_selection_numbers[j])
            upper_bound = average_reward + delta_i
        else:
            upper_bound = 1e400
        if upper_bound > max_upper_bound:
            max_upper_bound = upper_bound
            ad = j
    ad_selected.append(ad)
    ad_selection_numbers[ad] = ad_selection_numbers[ad] + 1
    reward = dataset.values[i,ad]
    sum_of_rewards[ad] = sum_of_rewards[ad] + reward
    total_reward = total_reward + reward

# Visualising the results
plt.hist(ad_selected)
plt.title('Histogram of ads selections')
plt.xlabel('Ads')
plt.ylabel('Number of times each ad was selected')
plt.show()