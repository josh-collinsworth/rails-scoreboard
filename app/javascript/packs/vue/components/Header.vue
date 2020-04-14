<template>
	<header>
		<a href="/">◀️ Back to Game list</a>
		<div>
			<button @click="togglePlayerMenu">Players</button>
			<button @click="toggleOptionsMenu">Game Options</button>
		</div>
		<Players :player-menu-open="playerMenuOpen" :game="game" @refresh="refresh" :alert="alert" :players="players" />
		<Options :options-menu-open="optionsMenuOpen" :game="game" :alert="alert" />
	</header>
</template>


<script>
import Options from './Options'
import Players from './Players'

export default {
	name: 'Header',
	components: {
		Options, Players
	},
	props: {
		game: {
			type: Object,
			required: true
		},
		players: {
			type: Array,
			required: true
		},
		alert: {
			type: Function,
			required: true
		},
		optionsMenuOpen: {
			type: Boolean,
			required: true
		},
		playerMenuOpen: {
			type: Boolean,
			required: true
		}
	},
	methods: {
		toggleOptionsMenu () {
			this.$emit('toggleOptionsMenu')
		},
		togglePlayerMenu () {
			this.$emit('togglePlayerMenu')
		},
		refresh() {
			this.$emit('refresh')
		}
	}
}
</script>


<style scoped lang="scss">
	@import '../../../../assets/stylesheets/vars';

	header {
		display: flex;
		align-items: center;
		justify-content: space-between;
		background: rgba($darkBlue, 0.95);
		color: $white;
		padding: .75rem;
		height: 4rem;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		z-index: 2;

		h1 {
			margin: 0;
		}

		button {
			background: $lightBlue;
			border-color: $darkGray;
			color: $darkGray;
			margin: 0 0 0 .5rem;

			&:hover {
				box-shadow: 0 0 0 2px $yellow;
			}
		}

		a {
			color: $white;
		}
	}
</style>
