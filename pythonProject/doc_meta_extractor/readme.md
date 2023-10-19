

# Metadata Extractor

This is a Flask web application designed to extract metadata from `.docx` and `.pdf` files. Users can upload a file, and the application will display its metadata, such as title, author, creation date, and more.

## Prerequisites

- `Python 3.x`
- `Flask`
- `python-docx`
- `PyPDF2`

## Installation

1. Clone this repository:

    ```bash
    git clone [your-repo-link]
    cd [your-repo-directory]
    ```

2. Install the required packages:

    ```bash
    pip install Flask python-docx PyPDF2
    ```

## Running the Application

To start the application, run:

```bash
python [your-app-file-name].py
```

Replace `[your-app-file-name].py` with the name of your Python file.

Once the server is running, you can access the application by navigating to:

```
http://127.0.0.1:5000/
```

## Features

- **File Upload:** Users can upload either a `.docx` or `.pdf` file to extract metadata.
  
- **Metadata Display:** After the successful upload and extraction process, the metadata of the file will be displayed to the user.
  
- **Error Handling:** The application handles various scenarios like missing file uploads, unsupported file types, and potential file reading errors.

## Endpoints

- **Home (`/`):** The main endpoint. It serves the file upload form on a GET request and handles the file upload and metadata extraction on a POST request.

## Notes

- Always be cautious when handling file uploads. Ensure that you have the necessary security measures in place if deploying in a production environment.
- This application runs in debug mode (`debug=True`) by default. It's recommended to set `debug=False` when deploying to production.
```
Developed by John D. Cyber @ https://Johndcyber.com