# Multimodal PSO-Based Color Image Segmentation

This MATLAB project implements an **image segmentation algorithm** based on a **multimodal particle swarm optimization (MMPSO)** technique applied to the RGB color space. The algorithm detects dominant color clusters and segments the image accordingly.

> **By Taymaz Rahkar Farshi (PhD)**  
> *A multimodal particle swarm optimization-based approach for image segmentation*  
> **Expert Systems with Applications**, 2020  
> [DOI: 10.1016/j.eswa.2020.113233](https://doi.org/10.1016/j.eswa.2020.113233)  
> taymaz.farshi@gmail.com  
> [ResearchGate Profile](https://www.researchgate.net/profile/Taymaz_RFarshi)  
> [Google Scholar](https://scholar.google.com/citations?user=l67ZmagAAAAJ&hl=en)  

---

##  Overview

This method segments images by:
1. Creating a 3D RGB histogram from the input image.
2. Applying Gaussian smoothing to the histogram.
3. Using MMPSO to identify multiple local maxima in the color space.
4. Assigning each image pixel to the closest cluster center.
5. Visualizing and evaluating the segmentation.

---

## 📁 Project Structure

- `main.m` — Main script to run the segmentation.
- `Hist3D.m` — Computes a 3D RGB histogram.
- `ColorSpace.m` — Visualizes the 3D color distribution.
- `PSO.m` — Core particle swarm optimization routine.
- `dellnich.m` — Niching method to remove close solutions.
- `Coloring.m` — Performs segmentation based on cluster centers.
- `Performance_Eval.m` / `Performance_Eval_2.m` — Evaluates the segmentation quality (F, F2, Q, RI, GCE, VOI).
- `image_hist_RGB_3d.m` — 3D histogram visualization.
- `LSelectrostatic/`, `altmany/` — Supporting folders (add to MATLAB path).
- `Results/` — Output folder (automatically created).

---

## ▶️ How to Run

1. Launch MATLAB and navigate to the project folder.
2. Run the main script:
   ```matlab
   main
