
import pandas as pd
import numpy as np
from sklearn.metrics import confusion_matrix
from sklearn.preprocessing import LabelEncoder
import matplotlib.pyplot as plt

X_train = pd.read_csv('training.csv', index_col=0).reset_index(drop=True)
X_test = pd.read_csv('testing.csv', index_col=0).reset_index(drop=True)

cat_cols = ['brand', 'sold']
print(X_train.columns)
for col in cat_cols:
    X_train[col] = LabelEncoder().fit_transform(X_train[col])
    X_test[col] = LabelEncoder().fit_transform(X_test[col])

y_train = X_train.pop('sold')
y_test = X_test.pop('sold')

import tensorflow as tf
available_devices = tf.config.experimental.list_physical_devices('GPU')
if len(available_devices) > 0:
    for gpu in tf.config.experimental.list_physical_devices('GPU'):
        tf.config.experimental.set_virtual_device_configuration(gpu, [
            tf.config.experimental.VirtualDeviceConfiguration(memory_limit=2048)])
        # tf.config.experimental.set_memory_growth(gpu, True)
from tensorflow import keras
from keras.layers import Dense, Dropout


def build_neural_network():
    ann = keras.Sequential()
    ann.add(Dense(32, activation='relu', input_shape=[len(X_train.columns)]))
    ann.add(Dense(1, activation='sigmoid'))

    ann.compile(loss=tf.keras.losses.BinaryCrossentropy(from_logits=False),
                optimizer=tf.keras.optimizers.Adam(learning_rate=0.00005), metrics=list(METRICS.keys())[1:])
    return ann


METRICS = {'loss': 'Binary Crossentropy', 'acc': 'Accuracy'}
model = build_neural_network()

EPOCH, BATCH_SIZE = 75, 128
history = model.fit(X_train, y_train, epochs=EPOCH, validation_split=0.2, verbose=2, batch_size=BATCH_SIZE, shuffle=True)
model.summary()

test_metrics = model.evaluate(X_test, y_test, verbose=0)
print('*** Test metrics ***')
for i, metric in enumerate(METRICS.keys()):
    print(metric, test_metrics[i])

predicted = model.predict(X_test)
both = np.hstack((predicted.reshape(predicted.shape[0], 1), np.array(y_test).reshape(y_test.shape[0], 1)), )
preds = pd.Categorical([1 if value > 0.5 else 0 for value in both[:, 0]])
trues = pd.Categorical(both[:, 1])
print(both)
print(confusion_matrix(trues, preds))


def plot_history(hist):
    hist_df = pd.DataFrame(hist.history)
    hist_df['epoch'] = hist.epoch

    for nn_metric in METRICS.keys():
        plt.figure()
        plt.xlabel('Epoch')
        plt.ylabel(METRICS[nn_metric])
        plt.plot(hist_df['epoch'], hist_df[nn_metric], label='Training')
        plt.plot(hist_df['epoch'], hist_df['val_' + nn_metric], label='Validation')
        plt.legend()
        plt.show()


plot_history(history)
