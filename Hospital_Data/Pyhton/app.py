import pandas as pd
import plotly.express as px
import streamlit as st

# ---------------- PAGE CONFIG ----------------
st.set_page_config(page_title="Healthcare Analytics", layout="wide")

# ---------------- LOAD DATA ----------------
df = pd.read_csv("E:\\Major_data_analysis_projects\\Hospital_Data\\Hospital_orignal_file.csv")

# Clean column names
df.columns = df.columns.str.strip().str.lower()

# ---------------- DATA CLEANING ----------------

# Fix Gender
df["patient gender"] = df["patient gender"].astype(str).str.strip().str.lower()
df["patient gender"] = df["patient gender"].replace({
    "f": "FEMALE",
    "m": "MALE",
    "female": "FEMALE",
    "male": "MALE"
})

# Convert Date
df["patient admission date"] = pd.to_datetime(df["patient admission date"])

# Create Age Group
bins = [0,10,20,30,40,50,60,70,80]
labels = ["0-9","10-19","20-29","30-39","40-49","50-59","60-69","70-79"]
df["age group"] = pd.cut(df["patient age"], bins=bins, labels=labels)

# ---------------- TITLE ----------------
st.title("🏥 Healthcare Analytics Dashboard")
st.markdown("Patient Flow & Operational Insights")

# ---------------- SIDEBAR ----------------
st.sidebar.header("Filters")

gender = st.sidebar.multiselect(
    "Select Gender",
    df["patient gender"].unique(),
    default=df["patient gender"].unique()
)

age_group = st.sidebar.multiselect(
    "Select Age Group",
    df["age group"].dropna().unique(),
    default=df["age group"].dropna().unique()
)

department = st.sidebar.multiselect(
    "Select Department",
    df["department referral"].unique(),
    default=df["department referral"].unique()
)

# Apply filters
filtered_df = df[
    (df["patient gender"].isin(gender)) &
    (df["age group"].isin(age_group)) &
    (df["department referral"].isin(department))
]

# ---------------- KPI SECTION ----------------
col1, col2, col3, col4 = st.columns(4)

if len(filtered_df) > 0:
    avg_wait = round(filtered_df["patient waittime"].mean(), 2)
    total_adm = len(filtered_df)
    avg_sat = round(filtered_df["patient satisfaction score"].mean(), 2)
    adm_rate = round((filtered_df["patient admission flag"].sum() / len(filtered_df)) * 100, 2)
else:
    avg_wait, total_adm, avg_sat, adm_rate = 0, 0, 0, 0

col1.metric("Avg Wait Time", f"{avg_wait} mins")
col2.metric("Total Admissions", total_adm)
col3.metric("Avg Satisfaction", avg_sat)
col4.metric("Admission Rate", f"{adm_rate}%")

st.markdown("---")

# ---------------- CHARTS ----------------

# Row 1
c1, c2 = st.columns(2)

# Avg Wait Time by Age Group
age_wait = filtered_df.groupby("age group")["patient waittime"].mean().reset_index()

fig1 = px.bar(
    age_wait,
    x="age group",
    y="patient waittime",
    color="age group",
    title="Avg Wait Time by Age Group"
)

# Y-axis fix (30–36)
fig1.update_layout(yaxis=dict(range=[30, 36]))

# Show values
fig1.update_traces(texttemplate='%{y:.1f}', textposition='outside')

c1.plotly_chart(fig1, use_container_width=True)

# Admissions over time
time_data = filtered_df.groupby("patient admission date")["patient admission flag"].sum().reset_index()

fig2 = px.line(
    time_data,
    x="patient admission date",
    y="patient admission flag",
    title="Admissions Over Time"
)

c2.plotly_chart(fig2, use_container_width=True)

# Row 2
c3, c4 = st.columns(2)

# Gender distribution
fig3 = px.histogram(
    filtered_df,
    x="patient gender",
    color="patient admission flag",
    barmode="group",
    title="Admissions by Gender"
)

c3.plotly_chart(fig3, use_container_width=True)

# Department referrals
fig4 = px.pie(
    filtered_df,
    names="department referral",
    title="Referrals by Department",
    hole=0.5
)

c4.plotly_chart(fig4, use_container_width=True)

# ---------------- INSIGHTS ----------------
st.markdown("---")
st.subheader("🔍 Key Insights")

st.write("• Highest wait time observed in 30–39 age group")
st.write("• Admissions peak during mid-year months")
st.write("• Balanced gender distribution between MALE and FEMALE")
st.write("• Majority patients come without referral")

# ---------------- ADVANCED ----------------
st.markdown("---")
st.subheader("📊 Advanced Analysis")

top_dept = filtered_df["department referral"].value_counts().head(5)
st.bar_chart(top_dept)