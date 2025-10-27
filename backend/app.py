from fastapi import FastAPI, File, UploadFile
import pandas as pd
import numpy as np
import io
import traceback

app = FastAPI(title="Warelytics API")

@app.post("/upload")
async def upload_xlsx(file: UploadFile = File(...)):
    contents = await file.read()
    try:
        # Read Excel file into DataFrame
        df = pd.read_excel(io.BytesIO(contents), sheet_name=0)
        
        # Replace NaN with None (JSON safe)
        df = df.replace({np.nan: None})
        
        # Return JSON records
        return df.to_dict(orient="records")

    except Exception as e:
        traceback.print_exc()  # Print full error to terminal
        return {"error": str(e)}
