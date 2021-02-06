import streamlit as st
from pydub import AudioSegment
from utils.toc import Toc
from utils.AudioPredict import AudioPredict
import plotly.graph_objects as go
import pandas as pd

@st.cache
def predict(uploaded_file):
    """
    Runs the model to find the mood
    Then provides some images to boost the mood
    """
    loc = AudioPredict.return_image(uploaded_file)
    return loc

def plot_chart():
    """
    Plotting a spider chart
    """
    fig = go.Figure(data=go.Scatterpolar(
    r=[1, 5, 2, 2, 3],
    theta=['happy','sad','anger', 'neutral','calm'],
    fill='toself'
    ))

    fig.update_layout(
    polar=dict(
        radialaxis=dict(
        visible=True
        ),
    ),
    showlegend=False
    )
    return fig

def self_assesment():
    """
    Some questions for self assessment for the user
    """
    questions = [
        "Little interest or pleasure in doing things",
        "Feeling down, depressed, or hopeless",
        "Trouble falling or staying asleep, or sleeping too much ",
        "Feeling tired or having little energy",
        "Poor appetite or overeating",
        "Feeling bad about yourself — or that you are a failure or have let yourself or your family down",
        "Trouble concentrating on things, such as reading the newspaper or watching television",
        "Moving or speaking so slowly that other people could have noticed? Or the opposite — being so fidgety or restless that you have been moving around a lot more than usual",
        "Thoughts that you would be better off dead or of hurting yourself in some way "]

    options = ['Not at all', 'Several days', 'More than half the days', 'Nearly every day']
    return (questions, options)

def main():
    toc = Toc()

    toc.title('Title here 😄😐😟')
    # uploading the file and getting the results
    toc.header("📁 Choose a file")
    uploaded_file = st.file_uploader("Select file from your directory")
    if uploaded_file is not None:
        audio_bytes = uploaded_file.read()
        st.audio(audio_bytes, format='audio/wav')

    # use the model for prediction
    loc = predict(uploaded_file)
    #web based link
    st.markdown("![Alt Text](https://media.giphy.com/media/xTiTnt7KZkTzJ7yHug/giphy.gif)")


    # Why self care is important
    toc.header('💖 Why is self care important ?')
    st.markdown(' We could write something here ')
    st.balloons()

    # Extra functionality 
    toc.header('🧩 Find your activity')
    st.radio('I can spend', ('5-10 mins', '10-30 mins', '30-60 mins'))
    st.radio('I want an activity ', ('Indoor', 'Outdoor'))
    st.button('Enter')


    # How was your day
    toc.header('📊 View your daily stats ')
    fig = plot_chart()
    st.plotly_chart(fig, use_container_width = True)

    

    toc.placeholder()
    toc.generate()

if __name__ == "__main__":
    main()