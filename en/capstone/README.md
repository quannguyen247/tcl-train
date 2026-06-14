# Capstone Project: AI-Powered Grader

This directory provides a capstone testing environment where you can put everything you've learned to the test.

## How it works

The i_grader.exe (or i_grader.py) uses Google's Gemini AI to dynamically generate realistic industry problems. Once you write your solution, the AI reviews your code, offers feedback on best practices, and gives you a score.

## Prerequisites

If you run the .py file instead of the .exe:
1. Install Python 3.9+.
2. Install the required libraries:
   \\\ash
   pip install -r requirements.txt
   \\\

## Getting Started

1. **Obtain an API Key**: Go to [Google AI Studio](https://aistudio.google.com/) and create a free API Key.
2. **Run the tool**:
   - Double-click i_grader.exe OR run python ai_grader.py in your terminal.
   - Enter your API Key when prompted.
3. **Generate**: Select Option 1. The AI will create a problem_statement.md in the workspace/ folder.
4. **Solve**: Open workspace/solution.tcl and write your Vivado Tcl script.
5. **Evaluate**: Select Option 2. The AI will evaluate your code and generate an evaluation.md file in the workspace with your score and feedback!

Enjoy coding!
