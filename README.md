# nekofetch
### Because who doesn't want their fetch tool to have cat ascii
##### Nekofetch is a simple little fetch tool implemented in under 30 lines of nim, and is fast enough to add to your shell config
---
## Dependencies
- noto-fonts-cjk
- wmctrl
- nim (makedep)
## Install
```bash
git clone --depth 1 https://github.com/arashi-software/nekofetch && cd nekofetch
nimble install
```
## Showcase
![image](https://github.com/arashi-software/nekofetch/assets/88919270/62730d75-0ffb-4751-9e6f-9afa852d66c2)
## Issues
If your fetch tags appear misaligned then you can remove or add a space to the corresponding line in `src/asciiart.txt` and then recompile.
If that doesn't solve it, or that wasn't your problem, feel free to open an issue on this github repo.
