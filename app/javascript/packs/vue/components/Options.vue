<template>
	<form id="options" :class="menuOpen && 'open'" :tabindex="menuOpen ? 0 : -1" :aria-hidden="!menuOpen">
		<div class="form-group">
			<label for="increment">Scores increment by:</label>
			<input type="number" id="increment" :value="game.options.increment" @change="updateIncrement">
		</div>
	</form>
</template>

<script>
import axios from 'axios'

export default {
	props: {
		menuOpen: {
			type: Boolean,
			required: true
		},
		game: {
			type: Object,
			required: true
		}
	},
	created() {
	},
	methods: {
		updateIncrement(e){
			console.log('updating!')
			let updatedGame = this.game
			updatedGame.options.increment = e.target.value
			const data = {
				game: updatedGame
			}
			axios.put(`/api/games/${this.game.id}`, data)
		}
	}
}
</script>

<style lang="scss" scoped>
	@import '../../../../assets/stylesheets/vars';

	#options {
		position: absolute;
		width: 100%;
		max-width: 24rem;
		padding: 1rem;
		min-height: calc(100vh - 100px);
		background: $lightBlue;
		right: 0;
		top: 4rem;
		transform: translateX(100%);
		transition: transform .2s $easing;

		&.open {
			transform: translateX(0);
		}
	}
</style>
