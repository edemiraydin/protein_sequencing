import streamlit as st
import py3Dmol
from stmol import showmol
from snowflake.snowpark import Session
from utils import create_session_object
import requests


@st.cache_data
def load_data():
    session = create_session_object()
    df = session.table("test_db.public.protein")
    return df.to_pandas()

df = load_data()


st.sidebar.title('Show Proteins')
#prot_str='TGFA_HUMAN,FABPL_HUMAN,TR10B_HUMAN,PIP_HUMAN'
#prot_list=prot_str.split(',')
bcolor = st.sidebar.color_picker('Pick A Color', '#00f900')
protein=st.sidebar.selectbox('select a protein',df["ID"].unique())
st.sidebar.text('Description:')
desc = df[df["ID"] == protein]["DESCRIPTION"].values[0].split("|")[2]
upid = df[df["ID"] == protein]["DESCRIPTION"].values[0].split("|")[1]

st.sidebar.write(desc)
style = st.sidebar.selectbox('style',['line','cross','stick','sphere','cartoon','clicksphere'])
spin = st.sidebar.checkbox('Spin', value = False)
filename="my-workspace/"+ str(protein) +".pdb"

# Loading the predicted structure saved in PDB file
with open(filename) as ifile:
    system = "".join([x for x in ifile])
xyzview = py3Dmol.view(query=protein)
xyzview.addModelsAsFrames(system)
xyzview.setStyle({style:{'color':'spectrum'}})
xyzview.setBackgroundColor(bcolor)
if spin:
    xyzview.spin(True)
else:
    xyzview.spin(False)
xyzview.zoomTo()
showmol(xyzview,height=500,width=800)

url = 'https://rest.uniprot.org/uniprotkb/'+str(upid)+'?fields=cc_function&format=tsv'
st.write(requests.get(url).text)
