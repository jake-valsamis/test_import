#!/usr/bin/env nextflow
// hash:sha256:ccb0b80f0fa2c67ab770c94a623c333e99edbec0dfe92eaea5a597ef05c173d0

nextflow.enable.dsl = 1

movies_to_create_model___toy_pipeline_1 = channel.fromPath("../data/movies/*", type: 'any', relative: true)
capsule_create_model_toy_pipeline_1_to_capsule_create_chunks_toy_pipeline_2_2 = channel.create()
capsule_create_chunks_toy_pipeline_2_to_capsule_run_inference_toy_pipeline_3_3 = channel.create()

// capsule - Create Model - Toy Pipeline
process capsule_create_model_toy_pipeline_1 {
	tag 'capsule-3996375'
	container 'registry.acmecorp-demo.codeocean.com/capsule/0333268e-299b-4d97-8c5b-04846a3584d4'

	cpus 1
	memory '8 GB'

	input:
	val path1 from movies_to_create_model___toy_pipeline_1

	output:
	path 'capsule/results/*' into capsule_create_model_toy_pipeline_1_to_capsule_create_chunks_toy_pipeline_2_2

	script:
	"""
	#!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	ln -s /tmp/data/movies/$path1 capsule/data/$path1 # id: e88f736d-3716-4ab8-b603-64d6258e1aef
	
	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@acmecorp-demo.codeocean.com/capsule-3996375.git" capsule-repo
	git -C capsule-repo checkout c856d2410d27157da5d8aff3aac8fc42234e5370 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Create Chunks - Toy Pipeline
process capsule_create_chunks_toy_pipeline_2 {
	tag 'capsule-8969161'
	container 'registry.acmecorp-demo.codeocean.com/capsule/e7712b75-49ea-454b-91ac-e2eae46b22da'

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_create_model_toy_pipeline_1_to_capsule_create_chunks_toy_pipeline_2_2

	output:
	path 'capsule/results/*' into capsule_create_chunks_toy_pipeline_2_to_capsule_run_inference_toy_pipeline_3_3

	script:
	"""
	#!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	ln -s /tmp/data/json_chunks capsule/data/json_chunks # id: f91575fb-5a4d-427f-a72e-99222765bc22
	
	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@acmecorp-demo.codeocean.com/capsule-8969161.git" capsule-repo
	git -C capsule-repo checkout 218f02a470cca3af8510f5b5f7bb04680f2e1495 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Run Inference - Toy Pipeline
process capsule_run_inference_toy_pipeline_3 {
	tag 'capsule-1228581'
	container 'registry.acmecorp-demo.codeocean.com/capsule/a204db74-b0c1-4b0f-83d6-e445fa756b76'

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_create_chunks_toy_pipeline_2_to_capsule_run_inference_toy_pipeline_3_3.flatten()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@acmecorp-demo.codeocean.com/capsule-1228581.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
