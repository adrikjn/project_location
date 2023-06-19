<?php

namespace App\Form;

use App\Entity\Membre;
use App\Entity\Commande;
use App\Entity\Vehicule;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;

class AdminCommandeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('dateHeureDepart', DateTimeType::class, [
            'widget' => 'single_text',
            'attr' => [
                'min' => (new \DateTime())->format('Y-m-d H:i'),
            ]
        ])
        ->add('dateHeureFin', DateTimeType::class, [
            'widget' => 'single_text'
        ])
        ->add('membre', EntityType::class, [
            'class' => Membre::class,
            'choice_label' => 'username'
        ])
        ->add('vehicule', EntityType::class, [
            'class' => Vehicule::class,
            'choice_label' => 'titre'
        ])
    ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Commande::class,
        ]);
    }
}
