<?php

namespace App\Controller;

use App\Entity\Commande;
use App\Entity\Vehicule;
use App\Form\CommandeType;
use App\Repository\CommandeRepository;
use App\Repository\VehiculeRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class MainController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function index(VehiculeRepository $repo): Response
    {
        return $this->render('main/index.html.twig', [
            'vehs' => $repo->findAll()
        ]);
    }

    
    
    #[Route("/main/resa/{id}", name:"resa_vehicule")]
    public function resa(Vehicule $vehicule = null, EntityManagerInterface $manager, Request $rq)
    {
        // si le véhicule n'existe pas, redirige vers la page d'accueil
        if (!$vehicule)
            return $this->redirectToRoute('app_main');

        $commande = new Commande;
        $form = $this->createForm(CommandeType::class, $commande);
        $form->handleRequest($rq);

        if ($form->isSubmitted() && $form->isValid()) {
            $commande->setMembre($this->getUser());
            $commande->setDateEnregistrement(new \DateTime());
            $commande->setVehicule($vehicule);

            $depart = $commande->getDateHeureDepart();
            if ($depart->diff($commande->getDateHeureFin())->invert == 1) {
                // si les dates sont incorrectes, recharge la page et affiche une erreur
                $this->addFlash('danger', 'Une période de temps ne peut pas être négative.');
                return $this->redirectToRoute('resa_vehicule', [
                    'id' => $vehicule->getId()
                ]);
            }
            $jours = $depart->diff($commande->getDateHeureFin())->days;
            $prixTotal = ($commande->getVehicule()->getPrixJournalier() * $jours) + $commande->getVehicule()->getPrixJournalier();
            // récupère le prix total (sans la dernière addition, il manque un jour à payer)

            $commande->setPrixTotal($prixTotal);

            $manager->persist($commande);
            $manager->flush();
            $this->addFlash('success', 'Votre commande a bien été enregistrée !');
            return $this->redirectToRoute('profil');
        }

        return $this->render('main/resa.html.twig', [
            'form' => $form,
            'veh' => $vehicule
        ]);
    }

    
     #[Route("/main/profil", name:"profil")]
    public function profil(CommandeRepository $repo)
    {
        $commandes = $repo->findBy(['membre' => $this->getUser()]);

        return $this->render("main/profil.html.twig", [
            'commandes' => $commandes
        ]);
    }
}
