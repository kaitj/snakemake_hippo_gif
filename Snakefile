import os.path as op
from snakemake.utils import format

configfile: "config.yaml" 

subj_prefix = "sub-S001"

in_dir = config["in_dir"]
out_dir = op.join(config["in_dir"], "out")

singularity_img = config["singularity"]

rule gif_hippo:
    input:
        nii_gz_path = op.join(in_dir, subj_prefix, f'{subj_prefix}_acq-MEMP2RAGE_hemi-L.nii.gz')
    output:
        nii_path = op.join(in_dir, subj_prefix, f'{subj_prefix}_acq-MEMP2RAGE_hemi-L.nii')
    log: 
        f'logs/gif_hippo/{subj_prefix}.log'
    singularity:
        singularity_img
    shell:
        "(gunzip -k {input.nii_gz_path} &&"
        "gif_your_nifti --fps 30 --cmap parula {output.nii_path}) &> {log}"

# include: "rules/subj.smk"