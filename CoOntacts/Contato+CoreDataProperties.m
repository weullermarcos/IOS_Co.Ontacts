//
//  Contato+CoreDataProperties.m
//  CoOntacts
//
//  Created by Weuller Marcos on 23/12/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "Contato+CoreDataProperties.h"

@implementation Contato (CoreDataProperties)

+ (NSFetchRequest<Contato *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Contato"];
}

@dynamic descricao;
@dynamic email;
@dynamic imagem;
@dynamic latitude;
@dynamic longitude;
@dynamic nome;
@dynamic telefone;

@end
