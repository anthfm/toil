import pandas as pd
import matplotlib.pyplot as plt
from wordcloud import WordCloud
import sys
import os

tt = pd.read_csv(sys.argv[1])
wordcloud2 = WordCloud().generate(' '.join(tt['word']))
base = os.path.basename(sys.argv[1])
out = base + "_cloud.png"
wordcloud2.to_file(out)