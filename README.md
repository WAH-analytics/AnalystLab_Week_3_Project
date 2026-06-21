# AnalystLab_Week_3_Project
Sales Data Sample and Chinook Dataset

# AnalystLab_Week_3_Project

## Chinook and Sample Sales Datasets
### AnalystLab Africa Data Analytics Internship Project

---

## Project Objective
The objective of this project was to transition from flat-file data processing to managing advanced relational database architectures and multi-table querying frameworks. The project focused on deploying real-world relational schemas, executing advanced multi-table joins and solving strategic business-driven questions using SQL.

---

## Datasets Used

### 1. Sample Sales Dataset 
*   **Source:** Kaggle - Sample Sales Data
*   **Description:** This operational dataset contains end-to-end transaction paths for a global manufacturing and retail business, including:
    *   Order details (Order Number, Quantity Ordered, Price Each, Order Line Number)
    *   Temporal logs (Order Date, Quarter, Month, Year)
    *   Product metadata (Product Line, MSRP, Product Code)
    *   Customer geography (Customer Name, Phone, Address, City, State, Postal Code, Country)
    *   Deal categorization (Deal Size)

### 2. Chinook Database (Digital Music Store Data)
*   **Source:** GitHub - lerocha/chinook-database
*   **Description:** This industry-standard, multi-table relational database models a digital media store, containing 11 interlinked tables tracking:
    *   **Catalog Infrastructure:** `artist`, `album`, `track`, `genre`, and `mediatype`
    *   **Commercial Transactions:** `invoice` and `invoiceline`
    *   **Corporate & Consumer Nodes:** `customer`, `employee`, `playlist`, and `playlisttrack`
---

## Tools Used

### SQL (MySQL Workbench)
SQL was leveraged as the core enterprise tool for:
*   Deploying complex, multi-table relational DDL scripts from raw repository sources.
*   Relational schema validation, primary/foreign key constraint enforcement, and index tracking.
*   Translating transactional raw metrics (milliseconds, units, prices) into strategic analytical insights.

---

## Data Cleaning & Database Setup Steps

### 1. Relational Database Reconstruction (Chinook)
*   Extracted the core raw SQL initialization script directly from the repository data source layer.
*   Executed structural DDL parameters to clear prior environment states (DROP DATABASE IF EXISTS) and build the 11 interconnected tables with proper auto-incrementing primary keys.
*   Populated over 15,000 lines of data across lookup tables and transaction registers, verifying data landing using metadata schema refreshes.

### 2. Data Type & Logic Correction (Sales Data)
*   **Price Logic Alignment:** Debugged a structural $100 price cap logic error embedded in the raw data to restore true transaction value.
*   **Temporal Formatting:** Converted string-based transaction logs into native DATETIME parameters to ensure proper chronological and seasonal filtering.
*  Standardized missing state, region, and postal variables across international consumer clusters to safeguard regional groupings.

---

## Key Findings

### Sample Sales Dataset
*  Aggregation metrics isolate **Classic Cars** as the primary commercial driver, contributing a dominant **$3,919,615.66** to gross sales, whereas **Trains** exhibits the weakest market penetration point at **$226,243.47**.
*  Applying analytical filtering via the `HAVING` clause to isolate territories exceeding a $500,000 threshold reveals the **United States ($3,627,982.83)** as the core market anchor, with **Spain ($1,215,686.92)** and **France ($1,110,916.52)** acting as leading European strongholds.

### Chinook Dataset
* Multi-table nested `JOIN` queries bridging catalog profiles with transactional records isolate **Iron Maiden** as the highest volume artist with **140 tracks sold ($138.60)**, followed closely by **U2** (**107 tracks; $105.93**) and **Metallica** (**91 tracks; $90.09**). This emphasizes the commercial power of heritage Rock and Heavy Metal profiles in digital music catalogs.
*  Aggregations mapping store architecture show **Rock** as the absolute inventory powerhouse, commanding **1,297 tracks** in the catalog with an average length of **4.73 minutes**. **Latin** holds the secondary spot with **579 tracks** (3.88 min average), followed by **Metal** with **374 tracks**, proving that the store's consumer base aligns heavily with long-form classic instrumentation genres.

---

## Conclusion
This project demonstrates the core value of relational data engineering and advanced querying in transforming raw database tables into targeted corporate insights. By moving beyond flat-file extraction into complex multi-table structures, the datasets were successfully shaped into highly reliable assets. The resulting models offer clear, strategic guidance for optimizing inventory distribution, executing geographic marketing allocations, and cultivating high-value consumer retention channels.

