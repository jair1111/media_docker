# This code sample uses the 'requests' library:
# http://docs.python-requests.org
import requests
from requests.auth import HTTPBasicAuth
import json

url = "https://georgipenin.atlassian.net/wiki/api/v2/pages/950273"

auth = HTTPBasicAuth("georgi.penin@gmail.com", "ATATT3xFfGF09ZDAUd2PIOV-opXxRieYcUtmgaJfBr5i6vgB0528ionlgY6xY6t3vOrl4P5a1ZpZhGF9SVAMEVkbQ1m2g_2rQaRuhyY-a1hksmuMOtdtdmiCPX8lDO7cUfHwq5dCeeipyVMExploEZub9XkkQzys-NxJDA3i6XsWcSNvnSbi1cc=82CFC489")

headers = {
  "Accept": "application/json",
  "Content-Type": "application/json"
}

payload = json.dumps( {
  "id": "950273",
  "status": "current",
  "title": "Updated title v5",
  "body": {
    "representation": "wiki",
    "value": "Auto update from Github actions<br>{attachments:old=false|sortby=name|page=Updated title v5|sortorder=descending|upload=false|preview=false}"
  },
  "version": {
    "number": 11,
    "message": "First auto update"
  }
} )

response = requests.request(
   "PUT",
   url,
   data=payload,
   headers=headers,
   auth=auth
)

print(json.dumps(json.loads(response.text), sort_keys=True, indent=4, separators=(",", ": ")))
