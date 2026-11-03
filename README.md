# Omen Key Launcher

⚠️ **Disclaimer:** This project was built as a personal experiment for my HP Victus laptop. It relies on device-specific WMI events and application paths, so it is not designed or guaranteed to work on other systems. The code is shared primarily for documentation and educational purposes.

Omen Key Launcher is a PowerShell-based project that repurposes the dedicated OMEN key on my HP Victus laptop to launch different applications based on the number of times it is pressed.

I built this project because I wanted to make better use of the dedicated OMEN key without relying on OMEN Gaming Hub. Instead of using the key for its original purpose, I wanted to turn it into a simple multi-action launcher.

The project was developed with AI assistance through vibe-coding. Its implementation is tailored to my device and personal workflow, rather than being intended as a general-purpose utility.

---

## How It Works (Overview)

- Uses the `hpqBEvnt` WMI event class in the `root\wmi` namespace to detect OMEN key presses.
- Identifies the specific event using `EventID 29` and `EventData 8613`.
- Counts consecutive key presses.
- Uses a 500-millisecond delay to determine when the user has finished pressing the key.
- Launches different applications depending on the number of presses:
    - 1 press → First application.
    - 2 presses → Second application.
    - 3 presses → Third application.
    - 4 or more presses → Plays an error sound.
- Plays a confirmation sound before launching an application.
- Uses `Start-Process` to launch applications.

---

## Project Structure

- `Omen Key Launcher.ps1` — Main PowerShell script containing the event detection and application-launching logic.
- `Omen Key Launcher.bat` — Launches the PowerShell script without displaying the usual console window.
- `audio/` — Local folder for the sound files used by the launcher.

---

## Development Journey

This project involved experimenting with Windows Management Instrumentation (WMI) to understand how the dedicated OMEN key communicates with Windows.

Some of the discoveries and limitations included:

- The OMEN key generates a WMI event when pressed.
- The event is triggered immediately on key press.
- Holding the key does not generate repeated events.
- No corresponding key-release event was detected through the WMI interface tested.
- Sleep functionality was explored but ultimately left out because the available power-state methods did not behave as intended on my system.

These limitations influenced the final multi-press approach.

---

## My System Specifications

- Laptop: HP Victus 15-fa0xxx
- Operating System: Windows 11 Home (64-bit)
- PowerShell: Windows PowerShell 5.1
- Hardware platform: HP motherboard 8A4F

---

## Final Thoughts

Omen Key Launcher started as a small experiment to give an otherwise dedicated hardware key a different purpose.

It was an interesting way to explore WMI, PowerShell event handling, process launching, and Windows hardware interactions.

The project is primarily a record of my development journey. It is not intended to be a maintained, universally compatible application.

> ⚠️ This project is tailored to my device and workflow. Other hardware configurations may behave differently or may not support the same WMI events.
