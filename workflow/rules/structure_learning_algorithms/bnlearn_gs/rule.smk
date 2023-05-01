rule gs:
    input:
        data=alg_input_data(),
    output:
        adjmat=alg_output_adjmat_path("bnlearn_gs"),
        time=alg_output_time_path("bnlearn_gs"),
        ntests=alg_output_ntests_path("bnlearn_gs"),
    container:
        "docker://bpimages/bnlearn:4.8.1"
    script:
        "bnlearn_gs.R"
