<template>
	<div class="alert">{{message}}
		<button @click="dismiss">
			×
		</button>
	</div>
</template>


<script>
export default {
	props: {
		message: {
			type: String,
			required: true
		}
	},
	methods: {
		dismiss(e) {
			e.target.parentElement.style.display = 'none';
		}
	}
}
</script>


<style scoped lang="scss">
@import '../../../../assets/stylesheets/vars';

	.alert {
		display: flex;
		align-items: center;

		button {
			background: transparent;
			padding: 0;
			margin: 0;
			border: none;
			font-size: 2em;
			line-height: .5em;
			margin-left: .5rem;
			cursor: pointer;

			&:hover {
				color: $yellow;
				box-shadow: none;
			}
		}
	}
</style>
