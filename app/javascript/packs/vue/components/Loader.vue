<template>
	<div id="loader">
		<h1>
			Loading
			<span class="dot"></span>
			<span class="dot"></span>
			<span class="dot"></span>
		</h1>
	</div>
</template>


<script>
export default {

}
</script>


<style scoped lang="scss">
@import '../../../../assets/stylesheets/vars';

	#loader {
		width: 100vw;
		height: 100vh;
		position: fixed;
		display: flex;
		align-items: center;
		justify-content: center;
		background: $lightBlue;
		top: 0;
		left: 0;
		color: $white;

		.dot {
			width: .2em;
			height: .2em;
			border-radius: .2em;
			background: $white;
			display: inline-block;
			transform-origin: center;
			animation: pop 1s infinite;

			&:nth-of-type(2) {
				animation-delay: .1s;
			}

			&:nth-of-type(3) {
				animation-delay: .2s;
			}
		}
	}

	@keyframes pop {
		0% {
			transform: scale(0)
		}
		10% {
			transform: scale(1.1)
		}
		18% {
			transform: scale(0.90)
		}
		26% {
			transform: scale(1.05)
		}
		33% {
			transform: scale(1)
		}
		64% {
			transform: scale(1)
		}
		72% {
			transform: scale(0)
		}
		100% {
			transform: scale(0)
		}
	}
</style>
