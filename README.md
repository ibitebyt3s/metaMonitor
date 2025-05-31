<<<<<<< HEAD
# metaMonitor
Lightweight batch script to ensure Metatrader Terminals are always running
=======
# 🖥️ metaMonitor.bat

**metaMonitor** is a lightweight batch script that monitors and ensures your MetaTrader 4/5 terminals are always running. If a terminal is not found, it will automatically restart it using its `.exe` path or an optional `.lnk` shortcut.

---

## 📦 Features

- ✅ Monitors multiple MetaTrader terminals (MT4 & MT5)
- 🚀 Auto-restarts terminals if they stop running
- 🧠 Supports `.lnk` shortcuts with custom icons or launch settings
- 📄 Logs all activity to `metaMonitor.log`
- 🔁 Can be set to run on Windows startup
- 💬 Simple plain-text configuration (`terminals.txt`)

---

## 📁 Recommended File Layout

For convenience and consistency, store all script-related files in a dedicated base folder, for example:

```
C:\Users\ibitebyt3s\Documents\metaMonitor\
│
├── metaMonitor.bat       :: Main monitoring script
├── terminals.txt         :: List of MetaTrader terminals to monitor
└── metaMonitor.log       :: Log file (auto-generated)
```

This structure keeps everything in one place, and ensures logs and configs stay organized.

---

## ⚙️ Configuration

At the top of `metaMonitor.bat`, you can customize these values:

```bat
set "TIMEOUT=60"        :: Time (in seconds) between monitoring cycles
set "START_DELAY=30"    :: Delay (in seconds) after starting a terminal
set "TERMINALS_FILE=terminals.txt"  :: Config file with terminal paths
set "LOG_FILE=metaMonitor.log"      :: Output log file
```

Feel free to edit these to match your desired frequency or log location.

- The default `TIMEOUT` is set to `60` seconds to avoid overloading the system with too many checks.
- The `START_DELAY` is set to `30` seconds because in my experience, opening multiple MetaTrader terminals too quickly often caused some or all of my Expert Advisors (EAs) to disappear. I suspect this happens when the system is under heavy load and can't initialize all charts and EAs properly at once — potentially resulting in data loss. A delay ensures the terminals have enough time to start cleanly before continuing the loop.

---

## 📝 Editing `terminals.txt`

Define each MetaTrader terminal you want to monitor. You can include:

- Only the `.exe` path
- Or the `.exe` path **plus** a `.lnk` shortcut, separated by a semicolon. Useful if you use shortcuts with custom icons.


Example:

```txt
# MT4 basic
C:\Program Files (x86)\Metatrader 4\terminal.exe

# MT4 with shortcut
C:\Program Files (x86)\Metatrader 4\terminal.exe;C:\Users\ibitebyt3s\Desktop\MT4Shortcut.lnk

# MT5 basic
C:\Program Files\MetaTrader 5\terminal64.exe

# MT5 with shortcut
C:\Program Files\MetaTrader 5\terminal64.exe;C:\Users\ibitebyt3s\Desktop\MT5Shortcut.lnk
```

Lines starting with `#` are ignored.

---

## 🚀 Running metaMonitor

You can start the script by double-clicking it, or by running it from Command Prompt:

```cmd
cd C:\Users\ibitebyt3s\Documents\metaMonitor
metaMonitor.bat
```

It will:
- Check if each terminal is running
- Start it if it's missing (via `.lnk` if provided)
- Append the result to `metaMonitor.log`
- Loop every `TIMEOUT` seconds

Leave the console window open to let it continue monitoring in the background.

---

## 🔄 Run on Windows Startup

To make `metaMonitor.bat` launch automatically when you log into Windows:

### 1. Create a Shortcut

- Right-click `metaMonitor.bat`
- Choose **Create shortcut**
- Rename the shortcut to something like `Start metaMonitor`

### 2. Open Startup Folder

Press `Win + R`, type `shell:startup`, and hit Enter.

This opens your personal startup folder:
```
C:\Users\ibitebyt3s\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```

### 3. Move the Shortcut

Move your `Start metaMonitor` shortcut into that folder.

✅ Now `metaMonitor.bat` will run automatically each time you log in.

📝 All logs will be saved in:
```
C:\Users\ibitebyt3s\Documents\metaMonitor\metaMonitor.log
```

---

## 🧪 Example Output

```
-----------------------------------
--------  metaMonitor v1.0 --------
-----------------------------------
2025-05-30 13:45:23 - ONLINE: C:\Program Files\MetaTrader 5\terminal64.exe
2025-05-30 13:45:23 - START:  C:\Users\ibitebyt3s\Desktop\MT4Shortcut.lnk
```

---

## 📃 License

[MIT License](LICENSE)

---

## ✨ Credits

Built with care by [@ibitebyt3s](https://github.com/ibitebyt3s)
Helping traders keep their MetaTrader terminals up and running — always.

>>>>>>> 485d9d8 (update README.md)
