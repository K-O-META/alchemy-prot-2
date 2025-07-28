class_name ReactionComponent extends Node2D


@export var essence: Enums.Essences = Enums.Essences.FIRE
@export var reaction: Enums.EssenceReaction = Enums.EssenceReaction.VULNERABLE


func reaction_for_damage(essence_t: Enums.Essences, damage: float) -> float:
	if essence_t == essence:
		if reaction == Enums.EssenceReaction.VULNERABLE:
			return damage * 2
		elif reaction == Enums.EssenceReaction.RESISTANT:
			return damage * 0.5
		elif reaction == Enums.EssenceReaction.HEALS_ME:
			return damage * -0.3

	return damage
