import os
from flask import Flask, request, render_template, flash, redirect, url_for
from werkzeug.utils import secure_filename
import docx
import PyPDF2
from io import BytesIO
import logging
from datetime import datetime

app = Flask(__name__)
app.secret_key = 'your-secret-key-change-this'  # Change this in production
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 16MB max file size

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

ALLOWED_EXTENSIONS = {'docx', 'pdf'}

def allowed_file(filename):
    """Check if file extension is allowed"""
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def format_date(date_obj):
    """Format date object to readable string"""
    if date_obj:
        if isinstance(date_obj, datetime):
            return date_obj.strftime('%Y-%m-%d %H:%M:%S')
        return str(date_obj)
    return 'Not available'

def extract_metadata_from_docx(doc):
    """Extract comprehensive metadata from DOCX file"""
    metadata = {}
    core_props = doc.core_properties
    
    # Basic metadata
    metadata['Title'] = getattr(core_props, 'title', None) or 'Not specified'
    metadata['Subject'] = getattr(core_props, 'subject', None) or 'Not specified'
    metadata['Author'] = getattr(core_props, 'creator', None) or 'Not specified'
    metadata['Keywords'] = getattr(core_props, 'keywords', None) or 'Not specified'
    metadata['Last Modified By'] = getattr(core_props, 'last_modified_by', None) or 'Not specified'
    metadata['Revision'] = getattr(core_props, 'revision', None) or 'Not specified'
    metadata['Modified Date'] = format_date(getattr(core_props, 'modified', None))
    metadata['Created Date'] = format_date(getattr(core_props, 'created', None))
    
    # Document structure
    metadata['Number of Paragraphs'] = len(doc.paragraphs)
    metadata['Number of Tables'] = len(doc.tables)
    
    # Word count
    word_count = 0
    for paragraph in doc.paragraphs:
        word_count += len(paragraph.text.split())
    metadata['Approximate Word Count'] = word_count
    
    return metadata

def extract_metadata_from_pdf(file):
    """Extract comprehensive metadata from PDF file"""
    metadata = {}
    try:
        pdf_reader = PyPDF2.PdfReader(file)
        info = pdf_reader.metadata
        
        if info:
            metadata['Title'] = getattr(info, 'title', None) or 'Not specified'
            metadata['Author'] = getattr(info, 'author', None) or 'Not specified'
            metadata['Subject'] = getattr(info, 'subject', None) or 'Not specified'
            metadata['Creator'] = getattr(info, 'creator', None) or 'Not specified'
            metadata['Producer'] = getattr(info, 'producer', None) or 'Not specified'
            metadata['Creation Date'] = format_date(getattr(info, 'creation_date', None))
            metadata['Modification Date'] = format_date(getattr(info, 'modification_date', None))
        else:
            metadata['Title'] = 'Not available'
            metadata['Author'] = 'Not available'
            metadata['Subject'] = 'Not available'
            metadata['Creator'] = 'Not available'
            metadata['Producer'] = 'Not available'
            metadata['Creation Date'] = 'Not available'
            metadata['Modification Date'] = 'Not available'
        
        metadata['Number of Pages'] = len(pdf_reader.pages)
        
        # Check if PDF is encrypted
        metadata['Encrypted'] = 'Yes' if pdf_reader.is_encrypted else 'No'
        
    except Exception as e:
        logger.error(f"Error extracting PDF metadata: {str(e)}")
        raise
    
    return metadata

@app.route('/', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        # Check if file was uploaded
        if 'file' not in request.files:
            flash('No file selected', 'error')
            return redirect(request.url)
        
        file = request.files['file']
        
        if file.filename == '':
            flash('No file selected', 'error')
            return redirect(request.url)
        
        if not allowed_file(file.filename):
            flash('Invalid file type. Please upload a .docx or .pdf file.', 'error')
            return redirect(request.url)
        
        try:
            filename = secure_filename(file.filename)
            file_bytes = BytesIO(file.read())
            
            if filename.lower().endswith('.docx'):
                doc = docx.Document(file_bytes)
                metadata = extract_metadata_from_docx(doc)
                file_type = 'DOCX'
            else:  # PDF
                file_bytes.seek(0)
                metadata = extract_metadata_from_pdf(file_bytes)
                file_type = 'PDF'
            
            # Add file information
            metadata['File Name'] = filename
            metadata['File Type'] = file_type
            
            return render_template('metadata.html', metadata=metadata, filename=filename)
            
        except Exception as e:
            logger.error(f"Error processing file {file.filename}: {str(e)}")
            flash(f'Error processing the file: {str(e)}', 'error')
            return redirect(request.url)
    
    return render_template('upload.html')

@app.errorhandler(413)
def too_large(e):
    flash('File is too large. Maximum size is 16MB.', 'error')
    return redirect(url_for('upload_file'))

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)