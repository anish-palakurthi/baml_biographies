from dotenv import load_dotenv 
load_dotenv() #needs to happen before importing baml_client

from baml_client import b
from baml_client.types import Biography


from fastapi import FastAPI
from fastapi.responses import StreamingResponse

app = FastAPI()


@app.get("/")
def index():
    return {"Hello": "World"}

@app.get("/stream_biographies")
async def generate_biographies(n):

    async def stream_biography(n):
        stream = b.stream.GenerateBiographies(n)
        async for chunk in stream:
            async for biography in chunk:
                yield str(biography) + "\n"


    return StreamingResponse(stream_biography(n))

