# ECG Signal Denoising with Wiener and Kalman Filters

## Project Overview
This project explores the application of Wiener and Kalman filters for ECG signal denoising. Both filters are implemented in MATLAB, and their performances are evaluated through time-domain and frequency-domain analyses.

## Contents
- **Wiener Filter**:
  - This is an optimal filter that is highly effective for removing stationary noise in stationary signals. In this project, this filter is used to remove noise from ECG data.
  - We observe that the Wiener filter effectively removes both powerline noise and high-frequency noise.
    ![image](https://github.com/user-attachments/assets/c0a28f9d-a9e3-4447-b593-5014db2c0150)

- **Kalman Filter**:
  - The Kalman filter is an adaptive filter that can remove both stationary and non-stationary noise. However, it requires specifying a noise profile at the beginning.
  - Although the Kalman filter performs well in typical scenarios, in this case, we observe that the Wiener filter outperforms it. This is primarily because I assumed the noise to be Gaussian white noise initially, but in this case, the main source of noise is powerline noise, which the Kalman filter struggles to handle compared to the Wiener filter.
    ![image](https://github.com/user-attachments/assets/e012d91c-b3d6-4559-8ebe-c015bf1e7c22)

## Acknowledgement
This project was completed as part of the BM4112 Medical Electronics and Instrumentation course.

---
