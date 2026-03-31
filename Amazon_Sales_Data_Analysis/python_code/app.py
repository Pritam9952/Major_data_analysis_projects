# app.py
import pandas as pd
import plotly.express as px
import streamlit as st
from PIL import Image

# Page config
st.set_page_config(
    page_title="Amazon Sales Dashboard",
    page_icon="📊",
    layout="wide"
)

# Optional logo at the top (comment out if no logo)
# logo = Image.open("logo.png")
# st.image(logo, width=120)

st.title("📊 Amazon Sales Dashboard")
st.markdown("#### Interactive dashboard to monitor Amazon sales KPIs")

# Load data
df = pd.read_csv("Amazon Sale Report.csv")

# Ensure Total_Revenue exists
if 'Total_Revenue' not in df.columns:
    df['Amount'] = df['Amount'].fillna(0)
    df['Qty'] = df['Qty'].fillna(0)
    df['Total_Revenue'] = df['Qty'] * df['Amount']

# Sidebar filters
st.sidebar.header("🔎 Filters")
states = st.sidebar.multiselect(
    "Select States:",
    options=df['ship-state'].dropna().unique(),
    default=df['ship-state'].dropna().unique()
)
statuses = st.sidebar.multiselect(
    "Select Order Status:",
    options=df['Status'].dropna().unique(),
    default=df['Status'].dropna().unique()
)

# Apply filters
df_filtered = df[
    (df['ship-state'].isin(states)) &
    (df['Status'].isin(statuses))
]

# KPIs
total_orders = df_filtered['Order ID'].nunique()
total_revenue = df_filtered['Total_Revenue'].sum()
avg_order_value = df_filtered['Total_Revenue'].mean()

col1, col2, col3 = st.columns(3)
col1.metric("📝 Total Orders", f"{total_orders:,}")
col2.metric("💰 Total Revenue (₹)", f"{total_revenue:,.0f}")
col3.metric("📦 Avg Order Value (₹)", f"{avg_order_value:,.2f}")

st.markdown("---")

# Download filtered data button
csv = df_filtered.to_csv(index=False).encode('utf-8')
st.download_button(
    label="⬇️ Download filtered data as CSV",
    data=csv,
    file_name='amazon_filtered.csv',
    mime='text/csv',
)

# Tabs for charts
tab1, tab2, tab3, tab4, tab5 = st.tabs([
    "📈 Sales Trend",
    "🏆 Top SKUs",
    "🗺 State-wise Revenue",
    "🚚 Fulfilment Channels",
    "🧾 B2B vs B2C"
])

with tab1:
    sales_trend = df_filtered.groupby('Date')['Total_Revenue'].sum().reset_index()
    fig1 = px.line(
        sales_trend,
        x='Date',
        y='Total_Revenue',
        title="Daily Sales Revenue Trend"
    )
    st.plotly_chart(fig1, use_container_width=True)

with tab2:
    top_skus = df_filtered.groupby('SKU')['Total_Revenue'] \
        .sum().sort_values(ascending=False).head(10).reset_index()
    fig2 = px.bar(
        top_skus,
        x='Total_Revenue',
        y='SKU',
        orientation='h',
        title="Top 10 SKUs by Revenue"
    )
    st.plotly_chart(fig2, use_container_width=True)

with tab3:
    state_rev = df_filtered.groupby('ship-state')['Total_Revenue'].sum().reset_index()
    fig3 = px.bar(
        state_rev.sort_values('Total_Revenue', ascending=False),
        x='Total_Revenue',
        y='ship-state',
        orientation='h',
        title="Revenue by State"
    )
    st.plotly_chart(fig3, use_container_width=True)

with tab4:
    fulfilment_rev = df_filtered.groupby('Fulfilment')['Total_Revenue'].sum().reset_index()
    fig4 = px.bar(
        fulfilment_rev,
        x='Fulfilment',
        y='Total_Revenue',
        title="Revenue by Fulfilment Channel"
    )
    st.plotly_chart(fig4, use_container_width=True)

with tab5:
    # This assumes you have a column like 'B2B' in your data; adjust if different
    if 'B2B' in df_filtered.columns:
        b2b_rev = df_filtered.groupby('B2B')['Total_Revenue'].sum().reset_index()
        fig5 = px.pie(
            b2b_rev,
            values='Total_Revenue',
            names='B2B',
            title="B2B vs B2C Revenue Split"
        )
        st.plotly_chart(fig5, use_container_width=True)
    else:
        st.info("No B2B/B2C column found in data to show split.")

st.markdown("---")
st.caption("Data Source: Amazon_Sales_Clean.csv")
st.caption(
    "Dashboard built with Streamlit + Plotly by [Pritam Nagar](https://www.linkedin.com/in/pritamnagar/)"
)
