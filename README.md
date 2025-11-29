AI Movie Success Predictor

Samantha Walter

CAP 4630


This project uses a neural network to predict whether a movie will be successul
based on simple metadata such as budget, popularity, runtime, vote count, and vote average. 


Requirements
The main dependencies need to be installed:
pip install numpy pandas sci-learn matplotlib tensorflow tqdm
These are are preinstalled in the notebook in Google Colab


Files
The file containing the Google Colab notebook with the code is called:
FinalProject_Walter.ipynb
The dataset that is used inside of the Google Colab notebook is called:
movie_data.csv (this is inside of the provided code)


The link for the page that contains the dataset that is used in the code:
https://www.kaggle.com/datasets/tmdb/tmdb-movie-metadata


How to Run
1. Open the notebook in Google Colab
2. Download the dataset from the link given
3. Upload the dataset to the notebook
4. Run all cells from top to bottom
5. Input any movie title from the list to get a prediction
Example code:
predict_movie_by_title("The Hobbit")


What the Code Does
- Loads and cleans the movie dataset
- Normalizes numerical features
- Splits the data into training, validation, and testing sets
- Builds and trains a Dense Neural Network (DNN)
- Prints accuracy and classification report
- Includes a function to predict success for a specific movie title
