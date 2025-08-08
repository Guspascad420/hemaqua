# 🧬 Hemaqua
An AI-ready mobile platform to assess water quality through **fish hematology analysis**, **mollusk hemocyte analysis**, and **standard aquatic parameters** (DO, pH, temperature, etc).

> Originally built as a research-backed app that successfully led to a Scopus Q1 journal publication in 2025.

---

## 📱 Tech Stack

- **Flutter** — Cross-platform mobile development
- **Firebase** — Auth & Realtime Database
- **Python / Streamlit (Web)** — Experimental analytics dashboard (WIP)
- **(Planned)**: AI integration for blood & cell detection (YOLOv8, ResNet)

---

## 🔬 Core Features

### ✅ Hematology Analysis (Fish Blood)
- Input parameters: Erythrocytes, Leukocytes, Hemoglobin, Hematocrit, etc
- Automatic status classification (Normal, Anemia, Infection)
- (Planned) AI cell detection from microscope images

### ✅ Hemocyte Analysis (Mollusks)
- Input parameters: THC, Hyalin, Granular, Semi-granular
- Status prediction based on reference ranges
- (Planned) Automated cell count via image detection

### ✅ Water Quality
- Calculate water health score based on:
    - Dissolved Oxygen (DO)
    - pH
    - Temperature
    - Ammonia, Nitrite, Nitrate, etc.
- Time-series parameter monitoring dashboard

### ✅ Species Detail Viewer
- Browse species data collected from field or lab
- View **Latin names**, **morphological descriptions**, and **ecological roles**
- Useful for cross-checking field observations and learning bioindicator functions

---

## 🧠 Upcoming Features
- [ ] AI-based microscope image detection (blood & hemocyte cells)
- [ ] Predictive modeling of water quality status
- [ ] Research export features for academic use
- [ ] Offline data entry support

---

## 📊 Use Cases

- Academic research in marine/fisheries biology
- Aquaculture water monitoring
- University lab practicals
- Potential B2B integrations for hatcheries, NGOs, and BRIN-level research

---

## 🚀 Getting Started

1. Clone the repo
   ```bash
   git clone https://github.com/yourusername/aquahealth-monitor.git
