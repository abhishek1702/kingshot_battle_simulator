import streamlit as st
import os
import re

# We remove the hardcoded H:/ path entirely for cloud compatibility!
from oct2py import Oct2Py

st.set_page_config(page_title="Battle Engine Simulator", layout="wide")

# ------------------------------------------------------------------
# 💾 PARSING PATTERNS (FOR .M FILE CONFIG RESTORATION)
# ------------------------------------------------------------------
def parse_matlab_file(content_str):
    extracted_data = {}
    matrix_patterns = {
        "Sa": r"Sa\s*=\s*\[(.*?)\]\s*;",
        "Sd": r"Sd\s*=\s*\[(.*?)\]\s*;",
        "Inf_att": r"Inf_att\s*=\s*\[(.*?)\]\s*;",
        "Cav_att": r"Cav_att\s*=\s*\[(.*?)\]\s*;",
        "Arch_att": r"Arch_att\s*=\s*\[(.*?)\]\s*;",
        "Inf_def": r"Inf_def\s*=\s*\[(.*?)\]\s*;",
        "Cav_def": r"Cav_def\s*=\s*\[(.*?)\]\s*;",
        "Arch_def": r"Arch_def\s*=\s*\[(.*?)\]\s*;"
    }
    var_patterns = {
        "rally": r"rally\s*=\s*([\d\.]+)\s*;",
        "t": r"\bt\s*=\s*([\d\.]+)\s*;"
    }
    for key, pattern in matrix_patterns.items():
        match = re.search(pattern, content_str, re.DOTALL)
        if match:
            nums = [float(x) for x in re.split(r'[;\s]+', match.group(1).strip()) if x]
            extracted_data[key] = nums
    for key, pattern in var_patterns.items():
        match = re.search(pattern, content_str)
        if match:
            extracted_data[key] = float(match.group(1))
    return extracted_data

if "parsed_config" not in st.session_state:
    st.session_state.parsed_config = {}

def get_ui_val(matrix_name, index, default):
    if matrix_name in st.session_state.parsed_config:
        try:
            return st.session_state.parsed_config[matrix_name][index]
        except IndexError:
            return default
    return default

def get_var_val(var_name, default):
    return st.session_state.parsed_config.get(var_name, default)

# ------------------------------------------------------------------
# 📂 UPLOAD CONTROLLER
# ------------------------------------------------------------------
st.title("🛡️ Strategic Battle Simulator Engine")

with st.expander("📂 Import Existing configuration file (`simulation_input.m`)", expanded=False):
    uploaded_file = st.file_uploader("Upload .m profile to refresh system view defaults", type=["m"])
    if uploaded_file is not None:
        try:
            file_contents = uploaded_file.getvalue().decode("utf-8")
            parsed_results = parse_matlab_file(file_contents)
            if parsed_results:
                st.session_state.parsed_config = parsed_results
                st.success("✅ Profile changes pulled to UI state memory! Modifying layout sliders...")
        except Exception as e:
            st.error(f"Error parsing script file variables: {e}")

# ------------------------------------------------------------------
# ⚔️ ROW 1: TROOP ALLOCATIONS (THREE COLUMNS)
# ------------------------------------------------------------------
st.markdown("---")
col_p_main, col_o_main = st.columns(2)

with col_p_main:
    st.header("🟢 Attacker Attributes")
    with st.container(border=True):
        st.subheader("Troop Allocations")
        inf_c, cav_c, arch_c = st.columns(3)
        
        with inf_c:
            st.markdown("**Infantry (Inf)**")
            p_inf = st.number_input("Count", value=int(get_ui_val("Inf_att", 0, 76500)), step=1000, key="p_inf_val")
            p_inf_tier = st.slider("Tier", 1, 11, int(get_ui_val("Inf_att", 1, 10)), key="p_inf_t")
            p_inf_tg = st.selectbox("TG Level", list(range(9)), index=int(get_ui_val("Inf_att", 2, 0)), key="p_inf_g")
            
        with cav_c:
            st.markdown("**Cavalry (Cav)**")
            p_cav = st.number_input("Count", value=int(get_ui_val("Cav_att", 0, 27000)), step=1000, key="p_cav_val")
            p_cav_tier = st.slider("Tier", 1, 11, int(get_ui_val("Cav_att", 1, 10)), key="p_cav_t")
            p_cav_tg = st.selectbox("TG Level", list(range(9)), index=int(get_ui_val("Cav_att", 2, 0)), key="p_cav_g")
            
        with arch_c:
            st.markdown("**Archery (Arch)**")
            p_arch = st.number_input("Count", value=int(get_ui_val("Arch_att", 0, 46500)), step=1000, key="p_arch_val")
            p_arch_tier = st.slider("Tier", 1, 11, int(get_ui_val("Arch_att", 1, 10)), key="p_arch_t")
            p_arch_tg = st.selectbox("TG Level", list(range(9)), index=int(get_ui_val("Arch_att", 2, 0)), key="p_arch_g")

with col_o_main:
    st.header("🔴 Defender Attributes")
    with st.container(border=True):
        st.subheader("Enemy Troop Allocations")
        o_inf_c, o_cav_c, o_arch_c = st.columns(3)
        
        with o_inf_c:
            st.markdown("**Enemy Infantry**")
            o_inf = st.number_input("Count", value=int(get_ui_val("Inf_def", 0, 60000)), step=1000, key="o_inf_val")
            o_inf_tier = st.slider("Tier", 1, 11, int(get_ui_val("Inf_def", 1, 10)), key="o_inf_t")
            o_inf_tg = st.selectbox("TG Level", list(range(9)), index=int(get_ui_val("Inf_def", 2, 0)), key="o_inf_g")
            
        with o_cav_c:
            st.markdown("**Enemy Cavalry**")
            o_cav = st.number_input("Count", value=int(get_ui_val("Cav_def", 0, 45000)), step=1000, key="o_cav_val")
            o_cav_tier = st.slider("Tier", 1, 11, int(get_ui_val("Cav_def", 1, 10)), key="o_cav_t")
            o_cav_tg = st.selectbox("TG Level", list(range(9)), index=int(get_ui_val("Cav_def", 2, 0)), key="o_cav_g")
            
        with o_arch_c:
            st.markdown("**Enemy Archery**")
            o_arch = st.number_input("Count", value=int(get_ui_val("Arch_def", 0, 45000)), step=1000, key="o_arch_val")
            o_arch_tier = st.slider("Tier", 1, 11, int(get_ui_val("Arch_def", 1, 10)), key="o_arch_t")
            o_arch_tg = st.selectbox("TG Level", list(range(9)), index=int(get_ui_val("Arch_def", 2, 0)), key="o_arch_g")

# ------------------------------------------------------------------
# ⚔️ ROW 2: COMBAT MODIFIERS
# ------------------------------------------------------------------
st.markdown("---")
col_p_mod, col_o_mod = st.columns(2)

with col_p_mod:
    st.subheader("⚔️ Attacker Modifiers")
    with st.container(border=True):
        m1, m2, m3 = st.columns(3)
        with m1:
            st.markdown("**Infantry Modifiers**")
            p_inf_atk = st.number_input("Attack (Sa)", value=get_ui_val("Sa", 0, 301.4), key="pia")
            p_inf_def = st.number_input("Defense (Sd)", value=get_ui_val("Sd", 0, 336.0), key="pid")
            p_inf_let = st.number_input("Lethality (Sa)", value=get_ui_val("Sa", 2, 81.0), key="pil")
            p_inf_hp  = st.number_input("Health (Sd)", value=get_ui_val("Sd", 2, 60.0), key="pih")
        with m2:
            st.markdown("**Cavalry Modifiers**")
            p_cav_atk = st.number_input("Attack (Sa)", value=get_ui_val("Sa", 4, 267.2), key="pca")
            p_cav_def = st.number_input("Defense (Sd)", value=get_ui_val("Sd", 4, 336.0), key="pcd")
            p_cav_let = st.number_input("Lethality (Sa)", value=get_ui_val("Sa", 6, 81.0), key="pcl")
            p_cav_hp  = st.number_input("Health (Sd)", value=get_ui_val("Sd", 6, 60.0), key="pch")
        with m3:
            st.markdown("**Archery Modifiers**")
            p_arc_atk = st.number_input("Attack (Sa)", value=get_ui_val("Sa", 8, 277.7), key="paa")
            p_arc_def = st.number_input("Defense (Sd)", value=get_ui_val("Sd", 8, 336.0), key="pad")
            p_arc_let = st.number_input("Lethality (Sa)", value=get_ui_val("Sa", 10, 81.0), key="pal")
            p_arc_hp  = st.number_input("Health (Sd)", value=get_ui_val("Sd", 10, 60.0), key="pah")

with col_o_mod:
    st.subheader("⚔️ Defender Modifiers")
    with st.container(border=True):
        om1, om2, om3 = st.columns(3)
        with om1:
            st.markdown("**Enemy Infantry**")
            o_inf_atk = st.number_input("Attack (Sa)", value=get_ui_val("Sa", 1, 301.4), key="oia")
            o_inf_def = st.number_input("Defense (Sd)", value=get_ui_val("Sd", 1, 336.0), key="oid")
            o_inf_let = st.number_input("Lethality (Sa)", value=get_ui_val("Sa", 3, 81.0), key="oil")
            o_inf_hp  = st.number_input("Health (Sd)", value=get_ui_val("Sd", 3, 60.0), key="oih")
        with om2:
            st.markdown("**Enemy Cavalry**")
            o_cav_atk = st.number_input("Attack (Sa)", value=get_ui_val("Sa", 5, 267.2), key="oca")
            o_cav_def = st.number_input("Defense (Sd)", value=get_ui_val("Sd", 5, 336.0), key="ocd")
            o_cav_let = st.number_input("Lethality (Sa)", value=get_ui_val("Sa", 7, 81.0), key="ocl")
            o_cav_hp  = st.number_input("Health (Sd)", value=get_ui_val("Sd", 7, 60.0), key="och")
        with om3:
            st.markdown("**Enemy Archery**")
            o_arc_atk = st.number_input("Attack (Sa)", value=get_ui_val("Sa", 9, 277.7), key="oaa")
            o_arc_def = st.number_input("Defense (Sd)", value=get_ui_val("Sd", 9, 336.0), key="oad")
            o_arc_let = st.number_input("Enemy Archery Lethality (Sa)", value=get_ui_val("Sa", 11, 81.0), key="oal")
            o_arc_hp  = st.number_input("Enemy Archery Health (Sd)", value=get_ui_val("Sd", 11, 60.0), key="oah")

# ------------------------------------------------------------------
# ⚔️ ROW 3: GLOBAL PARAMETERS CONFIG
# ------------------------------------------------------------------
st.markdown("---")
st.subheader("⚙️ Simulation Settings")
c_cfg1, c_cfg2, c_cfg3 = st.columns(3)

with c_cfg1:
    rally_bool = st.checkbox("Enable Rally Mode", value=bool(get_var_val("rally", 0)))
    rally_val = 1 if rally_bool else 0
    if rally_bool:
        st.warning("⚠️ Note: Rally mode is not implemented yet. Better formations will not be calculated.")

with c_cfg2:
    sparsity_val = st.selectbox("Sparsity Multiplier", options=[0.03, 0.06, 0.09, 0.12], index=0)

with c_cfg3:
    t_val = st.selectbox("Monte Carlo Iterations (t)", options=[5, 10, 20, 30, 40, 50], index=0)

# ------------------------------------------------------------------
# 🚀 ONLINE EXECUTION ENGINE
# ------------------------------------------------------------------
matlab_content = f"""Sa = [{p_inf_atk}; {o_inf_atk}; {p_inf_let}; {o_inf_let}; {p_cav_atk}; {o_cav_atk}; {p_cav_let}; {o_cav_let}; {p_arc_atk}; {o_arc_atk}; {p_arc_let}; {o_arc_let}];
Sd = [{p_inf_def}; {o_inf_def}; {p_inf_hp}; {o_inf_hp}; {p_cav_def}; {o_cav_def}; {p_cav_hp}; {o_cav_hp}; {p_arc_def}; {o_arc_def}; {p_arc_hp}; {o_arc_hp}];

Inf_att     = [ {p_inf} ; {p_inf_tier} ; {p_inf_tg} ; 1 ];
Cav_att     = [ {p_cav} ; {p_cav_tier} ; {p_cav_tg} ; 5 ];
Arch_att    = [ {p_arch} ; {p_arch_tier} ; {p_arch_tg} ; 9 ];

Inf_def     = [ {o_inf} ; {o_inf_tier} ; {o_inf_tg} ; 1 ];
Cav_def     = [ {o_cav} ; {o_cav_tier} ; {o_cav_tg} ; 5 ];
Arch_def    =