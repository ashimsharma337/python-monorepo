# Python Virtual Environment & pip — Quick Notes

## 1. Create a Virtual Environment

From the application directory:

```bash
cd apps/fastapi-postgres

python3 -m venv .venv
```

This creates an isolated Python environment:

```text
fastapi-postgres/
└── .venv/
```

---

## 2. Activate the Virtual Environment

### macOS / Linux

```bash
source .venv/bin/activate
```

### Windows

```powershell
.venv\Scripts\activate
```

You should see:

```text
(.venv)
```

in your terminal.

---

## 3. Verify the Python Environment

```bash
which python
```

macOS/Linux should point to:

```text
.../fastapi-postgres/.venv/bin/python
```

Check Python:

```bash
python --version
```

Check pip:

```bash
pip --version
```

Both should point to the `.venv` environment.

---

## 4. Install Packages

Example:

```bash
pip install fastapi uvicorn psycopg2-binary python-dotenv
```

Installed packages go into the virtual environment, not the global Python installation.

---

## 5. Check Installed Packages

```bash
pip list
```

or:

```bash
pip freeze
```

`pip freeze` shows installed packages with exact versions.

Example:

```text
fastapi==0.141.1
uvicorn==0.52.3
psycopg2-binary==2.9.12
python-dotenv==1.2.2
```

It also includes dependencies installed automatically by those packages.

---

## 6. Create `requirements.txt`

After installing packages:

```bash
pip freeze > requirements.txt
```

This records the packages and versions from the current virtual environment.

---

## 7. Install From `requirements.txt`

On another machine or after creating a new environment:

```bash
pip install -r requirements.txt
```

This recreates the environment from the dependency list.

---

## 8. Important: Activate the Environment First

Always activate the virtual environment before installing packages:

```bash
source .venv/bin/activate

pip install <package>
```

Otherwise, you may accidentally install packages into your global Python environment.

---

## 9. VS Code Interpreter

If VS Code shows:

```text
Import "fastapi" could not be resolved
```

make sure VS Code is using the project's virtual environment.

Open:

```text
Cmd + Shift + P
```

Then:

```text
Python: Select Interpreter
```

Select:

```text
.venv/bin/python
```

---

## 10. Typical Workflow

### First time

```bash
cd apps/fastapi-postgres

python3 -m venv .venv

source .venv/bin/activate

pip install fastapi uvicorn psycopg2-binary python-dotenv

pip freeze > requirements.txt
```

### Returning to the project

```bash
cd apps/fastapi-postgres

source .venv/bin/activate
```

### New machine

```bash
cd apps/fastapi-postgres

python3 -m venv .venv

source .venv/bin/activate

pip install -r requirements.txt
```

### Leave the virtual environment

```bash
deactivate
```

## Mental Model

```text
Python
  │
  └── Virtual Environment (.venv)
          │
          ├── FastAPI
          ├── Uvicorn
          ├── Psycopg2
          ├── python-dotenv
          │
          └── Dependencies
                    │
                    ▼
             requirements.txt
```

**Remember:**

> Create → Activate → Install → Freeze

```text
venv → activate → pip install → pip freeze
```