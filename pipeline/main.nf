#!/usr/bin/env nextflow
// hash:sha256:e2c8f006f5d443fd5dd06eee7441d83b8ef7da160fa812c247def931c77d0e1c

nextflow.enable.dsl = 1

movies_to_create_model___toy_pipeline_1 = channel.fromPath("../data/movies/*", type: 'any', relative: true)
capsule_create_model_toy_pipeline_1_to_capsule_create_chunks_toy_pipeline_2_2 = channel.create()
capsule_create_chunks_toy_pipeline_2_to_capsule_run_inference_toy_pipeline_3_3 = channel.create()
capsule_group_chunks_toy_pipeline_6_to_capsule_merge_chunks_toy_pipeline_5_4 = channel.create()
capsule_run_inference_toy_pipeline_3_to_capsule_group_chunks_toy_pipeline_6_5 = channel.create()

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

	export CO_CAPSULE_ID=0333268e-299b-4d97-8c5b-04846a3584d4
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	ln -s "/tmp/data/movies/$path1" "capsule/data/$path1" # id: e88f736d-3716-4ab8-b603-64d6258e1aef
	
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

	export CO_CAPSULE_ID=e7712b75-49ea-454b-91ac-e2eae46b22da
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	ln -s "/tmp/data/json_chunks" "capsule/data/json_chunks" # id: f91575fb-5a4d-427f-a72e-99222765bc22
	
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

	input:
	path 'capsule/data/' from capsule_create_chunks_toy_pipeline_2_to_capsule_run_inference_toy_pipeline_3_3.flatten()

	output:
	path 'capsule/results/*' into capsule_run_inference_toy_pipeline_3_to_capsule_group_chunks_toy_pipeline_6_5

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=a204db74-b0c1-4b0f-83d6-e445fa756b76
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@acmecorp-demo.codeocean.com/capsule-1228581.git" capsule-repo
	git -C capsule-repo checkout 43146cfe7870c7cf40ce4313ffb12e51329ea292 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Merge Chunks - Toy Pipeline
process capsule_merge_chunks_toy_pipeline_5 {
	tag 'capsule-0223110'
	container 'registry.acmecorp-demo.codeocean.com/capsule/cfc09b9d-c5b8-491a-81b4-db699a78ed92'

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_group_chunks_toy_pipeline_6_to_capsule_merge_chunks_toy_pipeline_5_4.flatten()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=cfc09b9d-c5b8-491a-81b4-db699a78ed92
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@acmecorp-demo.codeocean.com/capsule-0223110.git" capsule-repo
	git -C capsule-repo checkout 40fe5e95fc4bee27f92e1969db7a75d4aabe06f2 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Group Chunks - Toy Pipeline
process capsule_group_chunks_toy_pipeline_6 {
	tag 'capsule-2285849'
	container 'registry.acmecorp-demo.codeocean.com/capsule/852a2f3a-052b-41ca-a338-8dfcbae1fefc'

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_run_inference_toy_pipeline_3_to_capsule_group_chunks_toy_pipeline_6_5.collect()

	output:
	path 'capsule/results/*' into capsule_group_chunks_toy_pipeline_6_to_capsule_merge_chunks_toy_pipeline_5_4

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=852a2f3a-052b-41ca-a338-8dfcbae1fefc
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@acmecorp-demo.codeocean.com/capsule-2285849.git" capsule-repo
	git -C capsule-repo checkout 6d73679e8fb7f482433f93aff39df26f13da913d --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
