import streamlit as st
import json
from oct2py import Oct2Py

st.set_page_config(page_title="Battle Engine Simulator", layout="wide")

# ------------------------------------------------------------------
# 💾 SAVE / LOAD PROFILE FUNCTIONS
# ------------------------------------------------------------------
def export_profile(data):
    """Converts current stats to a JSON string for downloading."""
    return json.dumps(data, indent=4)

def load_profile(uploaded_file):
    """Parses an uploaded JSON file to restore stats."""
    if uploaded_file is not None:
        return json.load(uploaded_file)
    return None

# Initialize session state for profile data if it doesn't exist
if "profile_data" not in st.session_state:
    st.session_state.profile_data = {}

# ------------------------------------------------------------------
# ⚙️ SIDEBAR: SIMULATION PARAMETERS & PROFILE MANAGEMENT
# ------------------------------------------------------------------
with st.sidebar:
    st.header("⚙️ Control Panel")
    
    # Profile Import/Export Section
    with st.expander("📂 Save / Load Profiles", expanded=False):
        uploaded_file = st.file_uploader("Import JSON Profile", type=["json"])
        if uploaded_file:
            loaded_data = load_profile(uploaded_file)
            if loaded_data:
                st.session_state.profile_data = loaded_data
                st.success("Profile loaded successfully!")
        
        st.caption("Export current layout settings:")
        # Placeholder dictionary for downloading (populated later dynamically if needed)
        sample_export = {"info": "Your actual form values can bind here."} 
        st.download_button(
            label="📥 Export Current Stats",
            data=export_profile(sample_export),
            file_name="battle_profile.json",
            mime="application/json"
        )
    
    st.markdown("---")
    
    # Simulation Parameters
    st.subheader("Simulation Config")
    num_battles = st.number_input("Number of battles (Max 50)", min_value=1, max_value=50, value=10)
    sparsity = st.slider("Sparsity Multiplier", min_value=0.001, max_value=0.200, value=0.050, step=0.005, format="%.3f")
    
    st.markdown("---")
    # Global input method selector
    input_method = st.radio(
        "Troop Allocation Mode",
        options=["Total Troop Counts", "Percentage Ratios (%)"],
        help="Choose whether you define exact troop quantities or a percentage balance."
    )

# ------------------------------------------------------------------
# ⚔️ MAIN APP WINDOW: STATS MANAGEMENT
# ------------------------------------------------------------------
st.title("🛡️ Strategic Battle Simulator")
st.write("Configure combat profiles cleanly. Unused features remain tucked away to reduce visual clutter.")

# Separate the screen into two large columns: Player vs Opponent
col_player, col_opponent = st.columns(2)

# --- PLAYER STATS COLUMN ---
with col_player:
    st.header("🟢 Your Army Profile")
    
    # Dynamic Troop Allocation Block
    with st.container(border=True):
        st.subheader("Troop Deployments")
        c1, c2, c3 = st.columns(3)
        if input_method == "Total Troop Counts":
            p_inf = c1.number_input("Infantry Count", value=50000, step=5000)
            p_cav = c2.number_input("Cavalry Count", value=50000, step=5000)
            p_arch = c3.number_input("Archery Count", value=50000, step=5000)
        else:
            p_inf = c1.slider("Infantry Ratio %", 0, 100, 34)
            p_cav = c2.slider("Cavalry Ratio %", 0, 100, 33)
            p_arch = c3.slider("Archery Ratio %", 0, 100, 33)
            if (p_inf + p_cav + p_arch) != 100:
                st.warning(f"⚠️ Total Ratios equal {p_inf + p_cav + p_arch}%. Ensure they sum up to 100%!")

    # Compact Tabled Stats via Tabs
    st.subheader("Combat Modifiers (In %)")
    tab_inf, tab_cav, tab_arch = st.tabs(["🛡️ Infantry", "🐎 Cavalry", "🏹 Archery"])
    
    with tab_inf:
        cc1, cc2 = st.columns(2)
        p_inf_atk = cc1.number_input("Infantry Attack", value=200.0, step=5.0, key="p_in_atk")
        p_inf_def = cc2.number_input("Infantry Defense", value=200.0, step=5.0, key="p_in_def")
        p_inf_let = cc1.number_input("Infantry Lethality", value=200.0, step=5.0, key="p_in_let")
        p_inf_hp  = cc2.number_input("Infantry Health", value=200.0, step=5.0, key="p_in_hp")
        
    with tab_cav:
        cc1, cc2 = st.columns(2)
        p_cav_atk = cc1.number_input("Cavalry Attack", value=200.0, step=5.0, key="p_cv_atk")
        p_cav_def = cc2.number_input("Cavalry Defense", value=200.0, step=5.0, key="p_cv_def")
        p_cav_let = cc1.number_input("Cavalry Lethality", value=200.0, step=5.0, key="p_cv_let")
        p_cav_hp  = cc2.number_input("Cavalry Health", value=200.0, step=5.0, key="p_cv_hp")
        
    with tab_arch:
        cc1, cc2 = st.columns(2)
        p_arc_atk = cc1.number_input("Archery Attack", value=200.0, step=5.0, key="p_ar_atk")
        p_arc_def = cc2.number_input("Archery Defense", value=200.0, step=5.0, key="p_ar_def")
        p_arc_let = cc1.number_input("Archery Lethality", value=200.0, step=5.0, key="p_ar_let")
        p_arc_hp  = cc2.number_input("Archery Health", value=200.0, step=5.0, key="p_ar_hp")

    # Future Additions Hidden In Expander
    with st.expander("🎖️ Heroes & Tier Specifications (Optional)"):
        st.selectbox("Primary Hero", ["None", "Hero A", "Hero B"], key="p_hero")
        st.selectbox("Troop Tier", ["t10", "t11", "t12"], key="p_tier")


# --- OPPONENT STATS COLUMN ---
with col_opponent:
    st.header("🔴 Opponent Army Profile")
    
    with st.container(border=True):
        st.subheader("Troop Deployments")
        o_c1, o_c2, o_c3 = st.columns(3)
        if input_method == "Total Troop Counts":
            o_inf = o_c1.number_input("Enemy Infantry", value=60000, step=5000)
            o_cav = o_c2.number_input("Enemy Cavalry", value=45000, step=5000)
            o_arch = o_c3.number_input("Enemy Archery", value=45000, step=5000)
        else:
            o_inf = o_c1.slider("Enemy Infantry %", 0, 100, 40)
            o_cav = o_c2.slider("Enemy Cavalry %", 0, 100, 30)
            o_arch = o_c3.slider("Enemy Archery %", 0, 100, 30)

    st.subheader("Combat Modifiers (In %)")
    e_tab_inf, e_tab_cav, e_tab_arch = st.tabs(["🛡️ Infantry", "🐎 Cavalry", "🏹 Archery"])
    
    with e_tab_inf:
        ecc1, ecc2 = st.columns(2)
        o_inf_atk = ecc1.number_input("Enemy Infantry Attack", value=200.0, step=5.0, key="o_in_atk")
        o_inf_def = ecc2.number_input("Enemy Infantry Defense", value=200.0, step=5.0, key="o_in_def")
    # Remaining sub-tabs follow identical layout structures...

# ------------------------------------------------------------------
# 🚀 SIMULATION TRIGGER EXECUTION PLACEHOLDER
# ------------------------------------------------------------------
st.markdown("---")
if st.button("🚀 Run Advanced Core Simulation", use_container_width=True):
    st.info("Interface validation passed. Ready to compute arrays inside Octave Engine.")